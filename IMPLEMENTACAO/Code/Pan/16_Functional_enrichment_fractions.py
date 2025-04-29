from goatools.obo_parser import GODag
from goatools.associations import read_gaf
from goatools.go_enrichment import GOEnrichmentStudy

# Arquivos
obo_file = "go-basic.obo"
assoc_file = "gene2go.tsv"  # pode ser em formato GAF ou um .tsv simples

# Carregar estrutura GO
go_dag = GODag(obo_file)

# Carregar associações gene → GO
gene2go = read_gaf(assoc_file)

# Lista de desejos
f1 = open("study.txt", "r")
study_genes = f1.read().splitlines()
f1.close()

f2 = open("population.txt", "r")
pop_genes = f2.read().splitlines()
f2.close()

# Enriquecimento
goea_obj = GOEnrichmentStudy(
    pop_genes,   # background genes
    gene2go,     # gene2go mapping
    go_dag,      # ontology
    methods=["fdr_bh"]  # correção de múltiplos testes
)

results = goea_obj.run_study(study_genes)

# Mostrar resultados significativos
goea_obj.print_results(results, min_ratio=0.05, pval=0.05)
