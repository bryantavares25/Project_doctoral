import csv
from collections import defaultdict
from goatools.obo_parser import GODag
from goatools.goea.go_enrichment_ns import GOEnrichmentStudy

# Função para carregar os dados dos arquivos TSV
def carregar_go_termos(arquivo):
    gene2go = defaultdict(set)
    f = open(arquivo, "r")
    reader = csv.reader(f, delimiter="\t")
    next(reader)  # Pular cabeçalho
    for row in reader:
        if len(row) < 2:
            continue
        gene_id, go_terms = row[0], row[1]
        go_terms = go_terms.split(",")
        gene2go[gene_id].update(go_terms)
    f.close()
    return gene2go

# Carregar os dois grupos
grupo1 = carregar_go_termos("/home/lgef/InterTests/mhp_output.tsv")
grupo2 = carregar_go_termos("/home/lgef/InterTests/mfc_output.tsv")

# Criar listas de genes de interesse
genes_grupo1 = set(grupo1.keys())
genes_grupo2 = set(grupo2.keys())

# Criar um conjunto de referência (background) unindo os dois grupos
genes_background = genes_grupo1.union(genes_grupo2)

# Unindo anotações GO dos dois grupos para formar um dicionário gene-GO
gene2go = defaultdict(set)
for gene, gos in grupo1.items():
    gene2go[gene].update(gos)
for gene, gos in grupo2.items():
    gene2go[gene].update(gos)

# Carregar a ontologia GO
godag = GODag("/home/lgef/go-basic.obo")

# Criar o objeto de enriquecimento funcional
goeaobj = GOEnrichmentStudy(
    genes_background,  # Conjunto de referência
    gene2go,           # Associação gene-GO
    godag,             # Ontologia GO
    methods=["fdr_bh"] # Correção para múltiplos testes
)

# Rodar análise de enriquecimento para grupo 1 em relação ao background
goea_results1 = goeaobj.run_study(genes_grupo1)

# Rodar análise de enriquecimento para grupo 2 em relação ao background
goea_results2 = goeaobj.run_study(genes_grupo2)

# Imprimir os resultados na tela (se quiser visualizar no terminal)
goeaobj.prt_goea_results(goea_results1, pval=0.05)
goeaobj.prt_goea_results(goea_results2, pval=0.05)

# Salvar os resultados em arquivos TSV
f1 = open("/home/lgef/InterTests/mhp_go_enrichment_grupo1.tsv", "w")
goeaobj.prt_tsv(f1, goea_results1)
f1.close()

f2 = open("/home/lgef/InterTests/mfc_go_enrichment_grupo2.tsv", "w")
goeaobj.prt_tsv(f2, goea_results2)
f2.close()
