# # # F I G U R E S # # #

#import pylustrator
import matplotlib.pyplot as plt
import numpy as np
import csv
#pylustrator.start()

# FIGURA 1

'''Figura 1 - Comparar propriedades genômicos para avaliar os genomas completos e os genomas completados.
Propriedades:
    - Conteúdo GC 
    - Completude Busco Result
    - Cromossomos
    - Tamanho
    - Quantidade de Ns
'''

def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        data.append(line)
    return data


# FIGURE 1 A
data=tsv_read("/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/stats_DtC/totalleght.tsv")
category=data[0]
print(category)
values1=list(map(float, data[1]))  # Converte para int
print(values1)
values2=list(map(float, data[2]))  # Converte para int
print(values2)

# Configuração para barras lado a lado
x = np.arange(len(category))  # Posições no eixo X
largura = 0.35  # Largura das barras
fig, ax = plt.subplots() # Criação do gráfico
barras1 = ax.bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = ax.bar(x + largura/2, values2, largura, label='Whole', color='salmon')
# Personalização do gráfico
ax.set_xlabel('M. hyopneumoniae strains')
ax.set_ylabel('Scaffolds')
ax.set_title('Gráfico de Barras Lado a Lado')
ax.set_xticks(x)
ax.set_xticklabels(category, rotation=45, ha='right')
ax.tick_params(axis='x', labelsize=10)
ax.legend()
# Exibição
plt.tight_layout()
#% start: automatic generated code from pylustrator
plt.figure(1).ax_dict = {ax.get_label(): ax for ax in plt.figure(1).axes}
import matplotlib as mpl
getattr(plt.figure(1), '_pylustrator_init', lambda: ...)()
#% end: automatic generated code from pylustrator
plt.show()

