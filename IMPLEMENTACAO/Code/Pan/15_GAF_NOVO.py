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
go_dag = GODag("/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/go-basic.obo")

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

# Caminho dos arquivos
#dir = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/"
#infile_path = f"{dir}MFC_interpro_db.tsv"
#outfile_path = f"{dir}MFC_interpro_db_gaf.tsv"

#dir = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MHP/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/"
#infile_path = f"{dir}MHP_interpro_db.tsv"
#outfile_path = f"{dir}MHP_interpro_db_gaf.tsv"

dir = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MHP_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/"
infile_path = f"{dir}MHP_MFC_interpro_db.tsv"
outfile_path = f"{dir}MHP_MFC_interpro_db_gaf.tsv"

# Lê e processa sem usar 'with'
infile = open(infile_path, "r")
outfile = open(outfile_path, "w")

try:
    for line in infile:
        gene, go = line.strip().split("\t")
        aspect = get_aspect(go)
        gaf_line = f"{source}\t{gene}\t-\t-\t{go}\t{ref}\t{evidence}\t-\t{aspect}\t-\t{db}\t{taxon_id}\t{today}\t{assigned_by}\n"
        outfile.write(gaf_line)
finally:
    infile.close()
    outfile.close()

# O código acima lê um arquivo TSV contendo genes e IDs GO, determina o aspecto de cada ID GO usando a biblioteca goatools e escreve os resultados em um novo arquivo no formato GAF.