# # # # # # # # # D O C # # # # # # # # #

# # # LYBRARIES # # #
import csv

# # # FUNCTIONS # # #

def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        if line[2] == 'gene':
            data.append([line[0], line[3], line[4], line[6], line[8].split(';')[0]])
    return data
def tsv_create(archive):


# # # EXECUTION # # #

file_input = "/home/lgef/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_cleaned.gtf"
input = tsv_read(file_input)
for i in input:
    print(i)

file_output = "/home/lgef/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_cleaned.tsv"
tsv_create(file_output)

# END ------------------------------------

# # # B A R T # # #

# DRAF

# import pandas as pd
# from gtfparse import read_gtf
# Substitua 'seu_arquivo.gtf' pelo caminho para o seu arquivo GTF
# df = read_gtf('/home/lgef/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic.gff')
# Exibir as primeiras linhas do dataframe
#print(f"{df[3]['start']}")