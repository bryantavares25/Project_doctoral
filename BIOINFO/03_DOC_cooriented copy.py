import pandas as pd

# Simulação dos dados que você forneceu em um DataFrame
file = 'BIOINFO/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_gff_cleaned.tsv'
df = pd.read_csv(file, sep='\t', header=None, names=['seqname', 'start', 'end', 'strand', 'ID', 'Parent', 'Teste'])

# Converte as colunas de start e end para inteiros, se necessário
df['start'] = df['start'].astype(int)
df['end'] = df['end'].astype(int)

# Ordena o DataFrame pelos valores de 'start'
df = df.sort_values(by=['start']).reset_index(drop=True)

# Encontra grupos de genes co-orientados
co_oriented_groups = []
current_group = [df.iloc[0]['Parent']]
current_strand = df.iloc[0]['strand']

for i in range(1, len(df)):
    if df.iloc[i]['strand'] == current_strand and df.iloc[i]['start'] >= df.iloc[i-1]['end']:
        current_group.append(df.iloc[i]['Parent'])
    else:
        if len(current_group) >= 1:
            co_oriented_groups.append(current_group)
        current_group = [df.iloc[i]['Parent']]
        current_strand = df.iloc[i]['strand']

# Adiciona o último grupo se for co-orientado
if len(current_group) >= 1:
    co_oriented_groups.append(current_group)

# Exibe os grupos de genes co-orientados
a = 0
for group in co_oriented_groups:
    a = a+1
    print(f"Grupo de genes co-orientados: {', '.join(group)}")
print(a)