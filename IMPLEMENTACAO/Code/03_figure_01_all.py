# # # # # M A N U S C R I P T - F I G U R E S # # # # #

# # # F I G U R E - 01 # # #

# LIBRARIES

#import pylustrator
import matplotlib.pyplot as plt
import numpy as np
import csv
#pylustrator.start()

# FUNCTIONS

def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        data.append(line)
    return data

# DATA

mhp="/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/"
mfc="/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/"

data=tsv_read(f"{mhp}stats_dtc/scaffolds.tsv")
category=data[0]
print(category)
values1=list(map(int, data[1]))  # Converte para int
print(values1)
values2=list(map(int, data[2]))  # Converte para int
print(values2)

# EXECUTION

# Page confuiguration
fig, plots = plt.subplots(4, 2, figsize=(20, 16))

# Figure 01 A
x = np.arange(len(category))  # Posições no eixo X
largura = 0.35  # Largura das barras
barras1 = plots[0,0].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[0,0].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
#plots[0,0].set_xlabel('M. hyopneumoniae strains')
plots[0,0].set_ylabel('Scaffolds')
plots[0,0].set_title('Gráfico de Barras Lado a Lado')
plots[0,0].set_xticks(x)
plots[0,0].set_xticklabels([])
#plots[0,0].set_xticklabels(category, rotation=45, ha='right')
plots[0,0].tick_params(axis='x', labelsize=10)
plots[0,0].legend()
#plt.tight_layout()
plt.show() #
