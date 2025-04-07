'''import csv
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

f2 = open("/home/lgef/InterTests/go_enrichment_grupo2.tsv", "w")
goeaobj.prt_tsv(f2, goea_results2)
f2.close()
'''

'''
from goatools.obo_parser import GODag
from goatools.goea.go_enrichment_ns import GOEnrichmentStudy
from goatools.associations import read_gaf
from datetime import date

# 1. Carregar ontologia GO
obodag = GODag("/home/lgef/go-basic.obo")

# 2. Ler os dois arquivos GAF
assoc_all = read_gaf("/home/lgef/InterTests/MHP.gaf")  # associações de background
assoc_test = read_gaf("/home/lgef/InterTests/MFC.gaf")  # genes do grupo de interesse

# 3. Lista de genes
pop_ids = list(assoc_all.keys())  # todos os genes do GAF de background
study_ids = list(assoc_test.keys())  # genes do grupo A

# 4. Preparar objeto para enriquecimento
goeaobj = GOEnrichmentStudy(
    pop_ids,              # background
    assoc_all,            # associações GO para background
    obodag,               # ontologia
    propagate_counts=True,
    alpha=0.05,
    methods=['fdr_bh']    # correção de múltiplos testes (FDR)
)

# 5. Rodar análise de enriquecimento
results = goeaobj.run_study(study_ids)

# 6. Salvar resultados
goeaobj.wr_xlsx("/home/lgef/InterTests/resultado_enriquecimento.xlsx", results)
'''
import csv
from collections import defaultdict
from goatools.obo_parser import GODag
from goatools.goea.go_enrichment_ns import GOEnrichmentStudy

def carregar_go_termos(arquivo):
    """Carrega dados de arquivos TSV no formato gene-GO_terms."""
    gene2go = defaultdict(set)
    with open(arquivo, "r") as f:
        reader = csv.reader(f, delimiter="\t")
        next(reader)  # Pular cabeçalho
        for row in reader:
            if len(row) < 2:
                continue
            gene_id, go_terms = row[0], row[1]
            if go_terms:  # Verificar se há termos GO
                gene2go[gene_id].update(go_terms.split(","))
    return gene2go

# Carregar os dois grupos
grupo1 = carregar_go_termos("/home/lgef/InterTests/mhp_output.tsv")
grupo2 = carregar_go_termos("/home/lgef/InterTests/mfc_output.tsv")

# Criar listas de genes
genes_grupo1 = set(grupo1.keys())
genes_grupo2 = set(grupo2.keys())
genes_background = genes_grupo1.union(genes_grupo2)

# Unir anotações GO
gene2go = defaultdict(set)
gene2go.update(grupo1)
for gene, gos in grupo2.items():
    gene2go[gene].update(gos)

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

# Rodar análises
goea_results1 = goeaobj.run_study(genes_grupo1)
goea_results2 = goeaobj.run_study(genes_grupo2)

# Imprimir resultados - FORMA CORRETA
print("\n=== Resultados para Grupo 1 ===")
#goeaobj.print_results(goea_results1)  # Método correto para imprimir

print("\n=== Resultados para Grupo 2 ===")
#goeaobj.print_results(goea_results2)

# Salvar resultados em TSV
goeaobj.wr_tsv("/home/lgef/InterTests/mhp_go_enrichment_grupo1.tsv", goea_results1)
goeaobj.wr_tsv("/home/lgef/InterTests/mfc_go_enrichment_grupo2.tsv", goea_results2)