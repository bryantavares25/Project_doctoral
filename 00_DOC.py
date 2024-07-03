# # # D O C # # #

# LYBRARIES
import csv

# FUNCTIONS

def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        if line[2] == 'gene':
            data.append(line[8].split(';'))
    return data
def tsv_description_save(read_tsv_archive, i):
    description = []
    for line in read_tsv_archive:
        if line[0] == i:
            description.append(line[12])
    return description

# EXECUTION

a = tsv_read('/home/lgef/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_cleaned.gtf')
print(a)
#for i in a:
    #print(i)

# END

# # # B A R T # # #

# DRAF

# import pandas as pd
# from gtfparse import read_gtf
# Substitua 'seu_arquivo.gtf' pelo caminho para o seu arquivo GTF
# df = read_gtf('/home/lgef/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic.gff')
# Exibir as primeiras linhas do dataframe
#print(f"{df[3]['start']}")