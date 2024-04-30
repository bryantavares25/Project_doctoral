# # #

# # # # # L I B R A R I E S # # # # #

# In terminal pip install libraries
from Bio import SeqIO
import csv

# # # # # F U N C T I O N S # # # # #

# Function definition
def csv_read(archive):
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter=',')
    data = []
    for line in read_tsv:
        data.append(line[0])
    return data

# Function definition
def csv_selection(archive, ref_list):
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read = csv.reader(opened, delimiter=',')
    data = []
    for line in read:
        if line[0] in ref_list:
            data.append(line)
    return data

# Function definition
def csv_write(data, archive_final):
    archive = open(archive_final, 'w', newline='')
    escritor = csv.writer(archive, delimiter=',')
    escritor.writerows(data)

# # # # # E X E C U T I O N # # # # #

# STARTED : A FERRAMENTA FUNCIONA A PARTIR DA INSERÇÃO DOS ENDEREÇOS CORRETOS DOS ARQUIVOS
print("\n S T A R T E D \n")

# STEP 1 - Select target IDs: tsv ids -> list

archive_initial = "/home/lgef/Documentos/Marcelo_tool/selecionar.csv" # ARQUIVO COM IDS DE INTERESSE
ids_selected = csv_read(archive_initial)

# STEP 2 - Read data: tsv data -> list

archive_initial = "/home/lgef/Documentos/Marcelo_tool/banco.csv" # ARQUIVO COM OS DADOS DE INTERESSE
data_selected = csv_selection(archive_initial, ids_selected)

# STEP 3 - Create tsv: tsv id + tsv data -> new archive 
archive_final = "/home/lgef/Documentos/Marcelo_tool/novo.csv" # ARQUIVO CRIADO PARA EXPORTAR OS IDS E DADOS DE INTERESSE
csv_write(data_selected, archive_final)

# FINISHED
print("\n F I N I S H E D \n")

# Check result

# # # # # # # # # # B. A. R. T. # # # # # # # # # #