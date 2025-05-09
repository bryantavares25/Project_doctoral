import pandas as pd
from collections import defaultdict
from goatools.obo_parser import GODag
from goatools.go_enrichment import GOEnrichmentStudy

# === Etapa 1: carregar dados ===

# Arquivo de frações
df_frac = pd.read_csv("fractions.tsv", sep="\t")
gene2fraction = dict(zip(df_frac["gene_id"], df_frac["fraction"]))

# Arquivo de anotações GO
df_go = pd.read_csv("gene2go.tsv", sep="\t")
gene2gos = defaultdict(set)
for _, row in df_go.iterrows():
    gene2gos[row["gene_id"]].add(row["go_id"])

# Background: todos os genes anotados
all_genes = set(gene2gos.keys())

# === Etapa 2: carregar estrutura GO ===
obodag = GODag("go-basic.obo")

# === Etapa 3: montar e rodar o estudo de enriquecimento ===

# Exemplo: fração accessory
target_fraction = "accessory"
study_genes = [g for g, f in gene2fraction.items() if f == target_fraction and g in gene2gos]

goea = GOEnrichmentStudy(
    list(all_genes),      # universo
    gene2gos,             # anotações GO
    obodag,               # estrutura GO
    propagate_counts=False,
    alpha=0.05,           # limiar
    methods=["fdr_bh"]    # correção FDR
)

results = goea.run_study(study_genes)

# === Etapa 4: imprimir resultados significativos ===
for r in results:
    if r.p_fdr_bh < 0.05:
        print(f"{r.GO}\t{r.name}\t{r.p_fdr_bh:.4e}\t{r.study_count}/{r.study_n} genes")

# (Opcional) salvar em arquivo
significant = [r for r in results if r.p_fdr_bh < 0.05]
out = open("enrichment_accessory.tsv", "w")
out.write("GO_ID\tTerm\tp_FDR\tGenes_in_Fraction\n")
for r in significant:
    out.write(f"{r.GO}\t{r.name}\t{r.p_fdr_bh:.4e}\t{r.study_count}/{r.study_n}\n")
out.close()
