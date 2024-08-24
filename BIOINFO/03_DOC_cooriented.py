# Simulação dos dados que você forneceu em um DataFrame

# # # Adicionar verificação 

# Converte os dados para um DataFrame
from io import StringIO
import csv

import pandas as pd

file = 'BIOINFO/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_gff_cleaned.tsv'
df = pd.read_csv(file, sep='\t', header=None, names=['seqname', 'start', 'end', 'strand', 'ID', 'Parent'])

# Extrai os IDs dos genes co-orientados
co_oriented_groups = []
current_group = [df.iloc[0]['Parent']]
current_strand = df.iloc[0]['strand']

for i in range(1, len(df)):
    if df.iloc[i]['strand'] == current_strand:
        current_group.append(df.iloc[i]['Parent'])
    else:
        if len(current_group) > 1:
            co_oriented_groups.append(current_group)
        current_group = [df.iloc[i]['Parent']]
        current_strand = df.iloc[i]['strand']

# Adiciona o último grupo se for co-orientado
if len(current_group) > 1:
    co_oriented_groups.append(current_group)

# Exibe os grupos de genes co-orientados
for group in co_oriented_groups:
    print(f"Grupo de genes co-orientados: {', '.join(group)}")

