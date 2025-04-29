
# CHATGPT #

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

# CHATGPT #

# DEEPSEEK #
from goatools import obo_parser
from goatools.go_enrichment import GOEnrichmentStudy

# Carregar a ontologia GO
go_obo = "go-basic.obo"  # Arquivo OBO da GO
go = obo_parser.GODag(go_obo)

# Carregar anotações (gene-GO)
gene2go = "gene2go.txt"  # Formato: gene \t GO_ID
associations = {}
with open(gene2go) as f:
    for line in f:
        gene, go_id = line.strip().split('\t')
        associations.setdefault(gene, set()).add(go_id)

# Definir genes de interesse e população de referência
study_genes = ["gene1", "gene2", "gene3"]  # Exemplo
population_genes = list(associations.keys())  # Todos os genes anotados

# Executar análise de enriquecimento
methods = ["bonferroni", "fdr"]  # Correções para múltiplos testes
g = GOEnrichmentStudy(population_genes, associations, go, methods=methods)
result = g.run_study(study_genes)

# Salvar resultados
g.write_summary("enriquecimento_go.txt", result)
# DEEPSEEK #