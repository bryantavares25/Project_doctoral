'''from datetime import date
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

dir = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/"
infile_path = f"{dir}MFC_interpro_db.tsv"
outfile_path = f"{dir}MFC_interpro_db.gaf"

# Lê e processa sem usar 'with'
infile = open(infile_path, "r")
outfile = open(outfile_path, "w")

try:
    for line in infile:
        try:
            gene, go = line.strip().split("\t")
            aspect = get_aspect(go)
            if aspect != "-":  # Only include valid GO IDs with a recognized aspect
                gaf_line = f"{source}\t{gene}\t-\t-\t{go}\t{ref}\t{evidence}\t-\t{aspect}\t-\t{db}\t{taxon_id}\t{today}\t{assigned_by}\n"
                outfile.write(gaf_line)
        except ValueError:
            print(f"Skipping invalid line: {line.strip()}")
finally:
    infile.close()
    outfile.close()

# O código acima lê um arquivo TSV contendo genes e IDs GO, determina o aspecto de cada ID GO usando a biblioteca goatools e escreve os resultados em um novo arquivo no formato GAF.
'''

import csv

# Caminho do arquivo GAF original e o de saída corrigido
entrada = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/MFC_interpro_db.gaf"
saida = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/ANVIO_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/MFC_interpro_db_corrigido.gaf"

def corrigir_gaf(arquivo_entrada, arquivo_saida):
    with open(arquivo_entrada, "r") as f_in, open(arquivo_saida, "w", newline='') as f_out:
        reader = csv.reader(f_in, delimiter="\t")
        writer = csv.writer(f_out, delimiter="\t")

        for row_num, row in enumerate(reader, 1):
            # Pular linhas de comentários
            if not row or row[0].startswith("!"):
                writer.writerow(row)
                continue

            # Corrigir linhas que têm menos de 17 colunas
            nova_row = ["-"] * 17

            try:
                # Assumir que seu arquivo original tem colunas nesta ordem (ou algo próximo):
                # DB, ID, GO ID, Evidence, Namespace, Taxon, Date, AssignedBy
                nova_row[0] = row[0] if len(row) > 0 else "InterProScan"       # DB
                nova_row[1] = row[1] if len(row) > 1 else "-"                 # DB Object ID
                nova_row[2] = row[1] if len(row) > 1 else "-"                 # DB Object Symbol
                nova_row[3] = "involved_in"                                   # Relation
                nova_row[4] = row[4] if len(row) > 4 else "GO:0000000"       # GO ID
                nova_row[5] = row[5] if len(row) > 5 else "GO_REF:0000000"   # Reference
                nova_row[6] = row[6] if len(row) > 6 else "IEA"              # Evidence Code
                nova_row[7] = "-"                                            # With/From
                nova_row[8] = row[8] if len(row) > 8 else "F"               # Aspect
                nova_row[9] = "-"                                            # DB Object Name
                nova_row[10] = "-"                                           # Synonyms
                nova_row[11] = "protein"                                     # DB Object Type
                nova_row[12] = row[11] if "taxon" in row[11] else "taxon:12345"  # Taxon
                nova_row[13] = row[12] if len(row) > 12 else "-"            # Secondary taxon
                nova_row[14] = row[13] if len(row) > 13 else "20250430"     # Date
                nova_row[15] = row[14] if len(row) > 14 else "YourLab"      # Assigned By
                nova_row[16] = "-"                                           # Annotation Extension

                writer.writerow(nova_row)

            except Exception as e:
                print(f"Erro na linha {row_num}: {e}")
                continue

corrigir_gaf(entrada, saida)
