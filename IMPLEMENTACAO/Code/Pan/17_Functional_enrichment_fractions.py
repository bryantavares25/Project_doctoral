from goatools.obo_parser import GODag
from goatools.associations import read_gaf
from goatools.go_enrichment import GOEnrichmentStudy
from collections import defaultdict

# === 1. Carregar o GO DAG ===
obodag = GODag("/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/go-basic.obo")

# === 2. Ler anotações GO ===
gene2go = defaultdict(set)
f = open("/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/MFC_interpro_db.tsv", "r")
for line in f:
    gene, go_id = line.strip().split("\t")
    gene2go[gene].add(go_id)
f.close()

# === 3. Ler genes de interesse ===
study_genes = set()
f = open("/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/SUMMARY/FRACTIONS/fraction_core.txt", "r")
for line in f:
    study_genes.add(line.strip())
f.close()

# === 4. Definir genes de fundo ===
population_genes = set(gene2go.keys())

# === 5. Enriquecimento GO ===
goea = GOEnrichmentStudy(
    population_genes,
    gene2go,
    obodag,
    methods=["fdr_bh"]
)

results = goea.run_study(study_genes)

# === 6. Imprimir resultados significativos ===
for r in results:
    if r.p_fdr_bh < 0.5:
        print(f"{r.GO}: {r.name}, p={r.p_fdr_bh:.3e}, study_count={r.study_count}, pop_count={r.pop_count}")
'''

from goatools.obo_parser import GODag
from goatools.go_enrichment import GOEnrichmentStudy
from collections import defaultdict
import csv

# === Parâmetros configuráveis ===
p_cutoff = 0.5  # valor de corte para FDR ajustado
arquivo_go = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/go-basic.obo"
arquivo_gene2go = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/MFC_interpro_db.tsv"
arquivo_estudo = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/SUMMARY/FRACTIONS/fraction_shell_singletons.txt"
arquivo_saida = "go_enrichment_results.tsv"

# === 1. Carregar a ontologia GO ===
obodag = GODag(arquivo_go)

# === 2. Ler as anotações GO ===
gene2go = defaultdict(set)
f = open(arquivo_gene2go, "r")
for line in f:
    gene, go_id = line.strip().split("\t")
    gene2go[gene].add(go_id)
f.close()

# === 3. Ler os genes de interesse ===
study_genes = set()
f = open(arquivo_estudo, "r")
for line in f:
    study_genes.add(line.strip())
f.close()

# === 4. Definir os genes de fundo ===
population_genes = set(gene2go.keys())

# === 5. Executar a análise de enriquecimento ===
goea = GOEnrichmentStudy(
    population_genes,
    gene2go,
    obodag,
    methods=["fdr_bh"]
)

results = goea.run_study(study_genes)

# === 6. Abrir arquivo para escrita ===
out = open(arquivo_saida, "w", newline="")
writer = csv.writer(out, delimiter="\t")
writer.writerow(["GO_ID", "Name", "p_fdr_bh", "Study Count", "Pop Count", "Ratio_in_Study", "Ratio_in_Pop", "Depth", "Definition"])

# === 7. Escrever e imprimir termos significativos ===
for r in results:
    if r.p_fdr_bh < p_cutoff:
        writer.writerow([
            r.GO,
            r.name,
            f"{r.p_fdr_bh:.3e}",
            r.study_count,
            r.pop_count,
            f"{r.ratio_in_study[0]}/{r.ratio_in_study[1]}",
            f"{r.ratio_in_pop[0]}/{r.ratio_in_pop[1]}",
            r.depth,
            #r.goterm.definition
        ])
        print(f"{r.GO}: {r.name}, p={r.p_fdr_bh:.3e}, study={r.study_count}, pop={r.pop_count}")

# === 8. Fechar arquivo de saída ===
out.close()
print(f"\nResultados salvos em: {arquivo_saida}")
'''