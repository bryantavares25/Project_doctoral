# # # # # M A N U S C R I P T - F I G U R E S # # # # #

# # # F I G U R E - 01 # # #

# LIBRARIES

import pylustrator
import matplotlib.pyplot as plt
import numpy as np
import csv
pylustrator.start()

# FUNCTIONS

def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        data.append(line)
    return data

# DATA
mhp="/home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/"
mfc="/home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/"

# EXECUTION

# Page confuiguration
fig, plots = plt.subplots(4, 2, figsize=(20, 16))

# MHP

# Figure 01 A
data=tsv_read(f"{mhp}stats_dtc/totallenght.tsv")
category=data[0]
values1=list(map(int, data[1]))  # Converte para int
values2=list(map(int, data[2]))  # Converte para int

x = np.arange(len(category))
largura = 0.35
barras1 = plots[0,0].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[0,0].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
plots[0,0].set_ylabel('Total length (bp)')
plots[0,0].set_ylim(top=1000000)
plots[0,0].set_ylim(bottom=700000)
plots[0,0].set_xticks(x)
plots[0,0].set_xticklabels([])
plots[0,0].tick_params(axis='x', labelsize=10)
plots[0,0].legend()

# Figure 01 B
data=tsv_read(f"{mhp}stats_dtc/scaffolds.tsv")
category=data[0]
values1=list(map(int, data[1]))  # Converte para int
values2=list(map(int, data[2]))  # Converte para int
x = np.arange(len(category))
largura = 0.35
barras1 = plots[1,0].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[1,0].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
plots[1,0].set_ylabel('Scaffolds amount')
plots[1,0].set_yscale('log', base=2)
plots[1,0].grid(axis='y', linestyle='--', alpha=0.7)
plots[1,0].set_xticks(x)
plots[1,0].set_xticklabels([])
plots[1,0].tick_params(axis='x', labelsize=10)
plots[1,0].legend()

# Figure 01 C
data=tsv_read(f"{mhp}stats_dtc/gccontent.tsv")
category=data[0]
values1=list(map(float, data[1]))  # Converte para int
values2=list(map(float, data[2]))  # Converte para int
x = np.arange(len(category))
largura = 0.35
barras1 = plots[2,0].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[2,0].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
plots[2,0].set_ylabel('GC content')
plots[2,0].set_xticks(x)
plots[2,0].set_xticklabels([])
plots[2,0].tick_params(axis='x', labelsize=10)
plots[2,0].legend()

# Figure 01 D
data=tsv_read(f"{mhp}stats_dtc/completenessbusco.tsv")
category=data[0]
values1=list(map(float, data[1]))  # Converte para int
values2=list(map(float, data[2]))  # Converte para int
x = np.arange(len(category))
largura = 0.35
barras1 = plots[3,0].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[3,0].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
plots[3,0].set_ylabel('Completeness')
plots[3,0].set_xticks(x)
plots[3,0].set_xticklabels([])
plots[3,0].tick_params(axis='x', labelsize=10)
plots[3,0].legend()
plots[3,0].set_xticklabels(category, rotation=45, ha='right')

# MFC

# Figure 01 A
data=tsv_read(f"{mfc}stats_dtc/totallenght.tsv")
category=data[0]
values1=list(map(int, data[1]))  # Converte para int
values2=list(map(int, data[2]))  # Converte para int
x = np.arange(len(category))  # Posições no eixo X
largura = 0.35  # Largura das barras
barras1 = plots[0,1].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[0,1].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
#plots[0,0].set_xlabel('M. hyopneumoniae strains')
plots[0,1].set_ylabel('Total lenght')
plots[0,1].set_ylim(top=1000000)
plots[0,1].set_ylim(bottom=700000)
#plots[0,1].set_title('Gráfico de Barras Lado a Lado')
plots[0,1].set_xticks(x)
plots[0,1].set_xticklabels([])
#plots[0,0].set_xticklabels(category, rotation=45, ha='right')
plots[0,1].tick_params(axis='x', labelsize=10)
plots[0,1].legend()
#plt.tight_layout()

# Figure 01 B
data=tsv_read(f"{mfc}stats_dtc/scaffolds.tsv")
category=data[0]
values1=list(map(int, data[1]))  # Converte para int
values2=list(map(int, data[2]))  # Converte para int
x = np.arange(len(category))
largura = 0.35
barras1 = plots[1,1].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[1,1].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
plots[1,1].set_ylabel('Scaffolds amount')
plots[1,1].set_xticks(x)
plots[1,1].set_yscale('log')
plots[1,1].set_xticklabels([])
plots[1,1].tick_params(axis='x', labelsize=10)
plots[1,1].legend()

# Figure 01 C
data=tsv_read(f"{mfc}stats_dtc/gccontent.tsv")
category=data[0]
values1=list(map(float, data[1]))  # Converte para int
values2=list(map(float, data[2]))  # Converte para int
x = np.arange(len(category))
largura = 0.35
barras1 = plots[2,1].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[2,1].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
plots[2,1].set_ylabel('GC content')
plots[2,1].set_xticks(x)
plots[2,1].set_xticklabels([])
plots[2,1].tick_params(axis='x', labelsize=10)
plots[2,1].legend()

# Figure 01 D
data=tsv_read(f"{mfc}stats_dtc/completenessbusco.tsv")
category=data[0]
values1=list(map(float, data[1]))  # Converte para int
values2=list(map(float, data[2]))  # Converte para int
x = np.arange(len(category))
largura = 0.35
barras1 = plots[3,1].bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = plots[3,1].bar(x + largura/2, values2, largura, label='Whole', color='salmon')
plots[3,1].set_ylabel('Completeness')
plots[3,1].set_xticks(x)
plots[3,1].set_xticklabels([])
plots[3,1].tick_params(axis='x', labelsize=10)
plots[3,1].legend()
plots[3,1].set_xticklabels(category, rotation=45, ha='right')

plt.show() # PLOT

# END
