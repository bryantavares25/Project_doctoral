from collections import defaultdict
from goatools.obo_parser import GODag
from goatools.goea.go_enrichment_ns import GOEnrichmentStudy
from goatools.associations import read_gaf

# Carregar gene2go a partir de um arquivo GAF
gene2go = read_gaf("/home/lgef/go_annotations.gaf", namespace='BP')  # BP = Biological Process (pode ser BP, MF ou CC)

# Carregar listas de genes dos grupos de interesse
def carregar_lista_genes(caminho):
    with open(caminho, "r") as f:
        return set(line.strip() for line in f if line.strip())

# Listas de genes
genes_grupo1 = carregar_lista_genes("/home/lgef/InterTests/mhp_genes.txt")
genes_grupo2 = carregar_lista_genes("/home/lgef/InterTests/mfc_genes.txt")

# Fundo (background) = união dos dois grupos
genes_background = genes_grupo1.union(genes_grupo2)

# Carregar ontologia GO
godag = GODag("/home/lgef/go-basic.obo")

# Criar objeto de enriquecimento
goeaobj = GOEnrichmentStudy(
    genes_background,
    gene2go,
    godag,
    propagate_counts=True,
    methods=["fdr_bh"],
    alpha=0.05
)

# Rodar análises de enriquecimento
goea_results1 = goeaobj.run_study(genes_grupo1)
goea_results2 = goeaobj.run_study(genes_grupo2)

# Salvar resultados
goeaobj.wr_tsv("/home/lgef/InterTests/mhp_go_enrichment_grupo1.tsv", goea_results1)
goeaobj.wr_tsv("/home/lgef/InterTests/mfc_go_enrichment_grupo2.tsv", goea_results2)
