# # # D O C # # #

# LYBRARIES
import csv
import pandas
from gtfparse import read_gtf

# FUNCTIONS
# Substitua 'seu_arquivo.gtf' pelo caminho para o seu arquivo GTF
df = read_gtf('/home/lgef/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic.gff')

# EXECUTION
# Exibir as primeiras linhas do dataframe
print(f"{df[3]['start']}")

# END

# # # B A R T # # #