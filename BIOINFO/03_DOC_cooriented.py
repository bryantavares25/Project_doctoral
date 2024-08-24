import pandas as pd

# Simulação dos dados que você forneceu em um DataFrame
data = """NC_007332.1\t207\t1598\t+\tID=cds-WP_044272251.1\tParent=gene-MHP7448_RS00005
NC_007332.1\t1743\t2879\t+\tID=cds-WP_011289927.1\tParent=gene-MHP7448_RS00010
NC_007332.1\t2983\t4842\t+\tID=cds-WP_044272256.1\tParent=gene-MHP7448_RS00015
NC_007332.1\t4842\t5300\t+\tID=cds-WP_044272260.1\tParent=gene-MHP7448_RS00020
NC_007332.1\t5314\t6297\t+\tID=cds-WP_011289930.1\tParent=gene-MHP7448_RS00025
NC_007332.1\t6290\t7261\t-\tID=cds-WP_020835483.1\tParent=gene-MHP7448_RS00030
NC_007332.1\t7365\t7934\t+\tID=cds-WP_044272266.1\tParent=gene-MHP7448_RS00035
NC_007332.1\t8024\t9025\t+\tID=cds-WP_011205847.1\tParent=gene-MHP7448_RS00040
NC_007332.1\t9195\t11216\t+\tID=cds-WP_020835486.1\tParent=gene-MHP7448_RS00045
NC_007332.1\t11302\t12309\t+\tID=cds-WP_011205849.1\tParent=gene-MHP7448_RS00050
NC_007332.1\t12312\t13058\t+\tID=cds-WP_020835487.1\tParent=gene-MHP7448_RS00055
NC_007332.1\t12312\t13058\t+\tID=cds-WP_020835487.1\tParent=gene-MHP7448_RS00055
NC_007333.1\t12312\t13058\t+\tID=cds-WP_020835487.1\tParent=gene-MHP7448_RS00055
NC_007333.1\t12312\t13058\t+\tID=cds-WP_020835487.1\tParent=gene-MHP7448_RS00055
NC_007333.1\t12312\t13058\t+\tID=cds-WP_020835487.1\tParent=gene-MHP7448_RS00055"""

# # # Adicionar verificação 

# Converte os dados para um DataFrame
from io import StringIO

df = pd.read_csv(StringIO(data), sep='\t', header=None)
df.columns = ['seqname', 'start', 'end', 'strand', 'ID', 'Parent']

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

