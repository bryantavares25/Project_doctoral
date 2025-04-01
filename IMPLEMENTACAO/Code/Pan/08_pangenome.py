from goatools.obo_parser import GODag
from goatools.goea.go_enrichment_ns import GOEnrichmentStudy
from goatools.anno.gaf_reader import GafReader

# Carregar o banco de dados GO
godag = GODag("/home/lgef/go-basic.obo")

# Carregar anotações GO do GAF
gaf_obj = GafReader("goa_uniprot_all.gaf")
gene2go = gaf_obj.get_id2gos(namespace="BP")  # Filtrar por processo biológico (BP)

# Lista de genes de interesse
genes_interesse = {"WP_002557814", "WP_002557578"}  # Substitua pelos seus genes

# Criar um conjunto de genes de referência (background)
genes_background = set(gene2go.keys())

# Configurar o estudo de enriquecimento
goeaobj = GOEnrichmentStudy(
    genes_background,  # Conjunto de referência
    gene2go,           # Associação gene-GO
    godag,             # Ontologia GO
    methods=["fdr_bh"] # Correção para múltiplos testes (Benjamini-Hochberg)
)

# Realizar enriquecimento funcional
goea_results = goeaobj.run_study(genes_interesse)

# Exibir resultados significativos
goeaobj.print_results(goea_results, pval=0.05)
