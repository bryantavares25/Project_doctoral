# Simulação dos dados que você forneceu em um DataFrame

# # # Adicionar verificação de C O N T I G
# Converte os dados para um DataFrame

import pandas as pd

def tsv_create(data, archive):
    write_tsv_archive = open(archive,"w")
    for line in data:
        for i in line:
            write_tsv_archive.write(f"{i}\t")
        write_tsv_archive.write(f"\n")
    write_tsv_archive.close()

file = 'BIOINFO/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_cleaned_final.csv'
df = pd.read_csv(file, sep='\t', header=None, names=['seqname', 'start', 'end', 'strand', 'gene', 'ID'])

co_oriented_groups = []
current_group = [df.iloc[0]['ID']]
current_strand = df.iloc[0]['strand']

prot_ids_mhp7448 = ['MHP7448_RS00135', 'MHP7448_RS00160', 'MHP7448_RS00735', 'MHP7448_RS00780', 'MHP7448_RS00895', 'MHP7448_RS00965', 'MHP7448_RS01125', 'MHP7448_RS01645', 'MHP7448_RS01695', 'MHP7448_RS01760', 'MHP7448_RS01830', 'MHP7448_RS01965', 'MHP7448_RS02430', 'MHP7448_RS02535', 'MHP7448_RS02710', 'MHP7448_RS02825', 'MHP7448_RS02840', 'MHP7448_RS02910', 'MHP7448_RS03080', 'MHP7448_RS03310', 'MHP7448_RS03360', 'MHP7448_RS03395', 'MHP7448_RS03465', 'MHP7448_RS03555', 'MHP7448_RS03865', 'MHP7448_RS03870', 'MHP7448_RS04050']

for i in range(1, len(df)):
    for y in prot_ids_mhp7448:
        if df.iloc[i]['ID'] == y:
            print(y)

    if df.iloc[i]['strand'] == current_strand: #and df.iloc[i]['start'] >= df.iloc[i-1]['end']:
        current_group.append(df.iloc[i]['ID'])
    else:
        if len(current_group) >= 1:
            print(df.iloc[i]['strand'])
            co_oriented_groups.append(current_group)
        current_group = [df.iloc[i]['ID']]
        current_strand = df.iloc[i]['strand']

if len(current_group) >= 1:
    co_oriented_groups.append(current_group)


# Exibe os grupos de genes co-orientados
a = []
prot_ids_mhp7448 = ['MHP7448_RS00135', 'MHP7448_RS00160', 'MHP7448_RS00735', 'MHP7448_RS00780', 'MHP7448_RS00895', 'MHP7448_RS00965', 'MHP7448_RS01125', 'MHP7448_RS01645', 'MHP7448_RS01695', 'MHP7448_RS01760', 'MHP7448_RS01830', 'MHP7448_RS01965', 'MHP7448_RS02430', 'MHP7448_RS02535', 'MHP7448_RS02710', 'MHP7448_RS02825', 'MHP7448_RS02840', 'MHP7448_RS02910', 'MHP7448_RS03080', 'MHP7448_RS03310', 'MHP7448_RS03360', 'MHP7448_RS03395', 'MHP7448_RS03465', 'MHP7448_RS03555', 'MHP7448_RS03865', 'MHP7448_RS03870', 'MHP7448_RS04050']
for i in prot_ids_mhp7448:
    for group in co_oriented_groups:
        if i in group:
            #print(group)
            a.append([i, group])

archive = '/home/lgef/Documentos/GitHub/Project_doctoral/BIOINFO/03_outputclusters.tsv'
tsv_create(a, archive)

# Identificação da orientação dos clusters gênicos
#b = []
#for i in prot_ids_mhp7448:
#    for l in df:
#        if i == l:
#            print(i) 
