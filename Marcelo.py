# # #

# in terminal pip install libraries
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
def tsv_select(read, ref_list):
    select = []
    test = []
    for line in read:
        if line[3] in ref_list:
            select.append(line[0])
            test.append(line[3])
    print(test)
    return select

def tsv_write(data):
    with open(file_final, 'w', newline='') as arquivo_tsv:
        escritor = csv.writer(arquivo_tsv, delimiter=',')  # Define o delimitador como tabulação
        escritor.writerows(dados)  # Escreve todos os dados

# # #

file_initial = "/home/lgef/Documentos/banco.csv"

select = []

file_final = "/home/lgef/Documentos/novo.csv"

dados = tsv_read(file_initial)

tsv_write(dados)
