# # #

# # # # # L I B R A R I E S # # # # #

# In terminal pip install libraries
from Bio import SeqIO
import csv

# # # # # F U N C T I O N S # # # # #

# Function definition
def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        data.append(line)
    return data

# Function definition
def tsv_selection(read, ref_list):
    select = []
    for line in read:
        if line[0] in ref_list:
            select.append(line[0])
    print(select)
    return select

    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        data.append(line)
    return data


# Function definition
def tsv_write(data):
    open

    with open(archive_final, 'w', newline='') as archive_final:
        escritor = csv.writer(archive_final, delimiter=',')  # Define o delimitador como tabulação
        escritor.writerows(data)  # Escreve todos os dados

# # # # # E X E C U T I O N # # # # #

# STARTED
print("\n S T A R T E D \n")

# STEP 1 - Select target IDs: tsv ids -> list

archive_initial = "/home/lgef/Documentos/Marcelo_tool/selecionar.csv"
ids_selected = tsv_read(archive_initial)

# STEP 2 - Read data: tsv data -> list

archive_initial = "/home/lgef/Documentos/Marcelo_tool/banco.csv"
data_selected = tsv_selection(archive_initial, ids_selected)

# STEP 3 - Create tsv: tsv id + tsv data -> new archive 
archive_final = "/home/lgef/Documentos/Marcelo_tool/novo.csv"
tsv_write(data_selected)

# FINISHED
print("\n F I N I S H E D \n")

# # # # # # # # # # B. A. R. T. # # # # # # # # # #