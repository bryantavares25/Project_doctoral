from datetime import date
from goatools.obo_parser import GODag

# Parâmetros fixos
source = "InterProScan"
ref = "GO_REF:0000002"
evidence = "IEA"
db = "InterProScan"
taxon_id = "taxon:12345"  # substitua pelo ID real da sua bactéria
today = date.today().strftime("%Y%m%d")
assigned_by = "YourLab"

# Carrega o arquivo .obo
go_dag = GODag("/home/lgef/go-basic.obo")  # baixe antes e coloque no mesmo diretório

# Função para determinar o aspecto (F, P ou C)
def get_aspect(go_id):
    if go_id not in go_dag:
        return "-"
    namespace = go_dag[go_id].namespace
    if namespace == "molecular_function":
        return "F"
    elif namespace == "biological_process":
        return "P"
    elif namespace == "cellular_component":
        return "C"
    else:
        return "-"

# Abrir arquivos manualmente
#dir="/home/lgef/InterTests/"
dir="/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/"
infile = f"{dir}MFC_interpro_db.tsv"
outfile = f"{dir}MFC_interpro_db_gaf.tsv"

#infile = open("/home/lgef/InterTests/mhp_output.tsv", "r")
#outfile = open("/home/lgef/InterTests/MHP_GAF", "w")

for line in infile:
    gene, go_str = line.strip().split("\t")
    go_terms = go_str.split(",")
    for go in go_terms:
        aspect = get_aspect(go)
        gaf_line = f"{source}\t{gene}\t-\t-\t{go}\t{ref}\t{evidence}\t-\t{aspect}\t-\t{db}\t{taxon_id}\t{today}\t{assigned_by}\n"
        outfile.write(gaf_line)

# Fechar arquivos
infile.close()
outfile.close()
