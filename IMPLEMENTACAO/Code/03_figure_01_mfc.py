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
data=tsv_read("/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/Stats_DtC/scaffolds.tsv")
category=data[0]
print(category)
values1=list(map(int, data[1]))  # Converte para int
print(values1)
values2=list(map(int, data[2]))  # Converte para int
print(values2)

# Configuração para barras lado a lado
x = np.arange(len(category))  # Posições no eixo X
largura = 0.35  # Largura das barras
fig, bx = plt.subplots() # Criação do gráfico
barras1 = bx.bar(x - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = bx.bar(x + largura/2, values2, largura, label='Whole', color='salmon')
# Personalização do gráfico
bx.set_xlabel('M. hyopneumoniae strains')
bx.set_ylabel('Scaffolds')
bx.set_title('Gráfico de Barras Lado a Lado')
bx.set_xticks(x)
bx.set_xticklabels(category, rotation=45, ha='right')
bx.tick_params(bxis='x', labelsize=5)



bx.legend()
# Exibição
plt.tight_layout()
#% start: automatic generated code from pylustrator
plt.figure(1).bx_dict = {bx.get_label(): bx for bx in plt.figure(1).bxes}
import matplotlib as mpl
getattr(plt.figure(1), '_pylustrator_init', lambda: ...)()
#% end: automatic generated code from pylustrator
plt.show()

