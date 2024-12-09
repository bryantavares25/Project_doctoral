'''# # # F I G U R E S # # #

#import pylustrator
import matplotlib.pyplot as plt
import numpy as np
import csv
#pylustrator.start()

# FIGURA 1

'''

'''Figura 1 - Comparar propriedades genômicos para avaliar os genomas completos e os genomas completados.
Propriedades:
    - Conteúdo GC 
    - Completude Busco Result
    - Cromossomos
    - Tamanho
    - Quantidade de Ns
'''
'''
def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        data.append(line)
    return data


# FIGURE 1 A
data=tsv_read("/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/stats_DtC/scaffolds.tsv")
category=data[0]
print(category)
values1=list(map(int, data[1]))  # Converte para int
print(values1)
values2=list(map(int, data[2]))  # Converte para int
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

y = np.arange(len(category))  # Posições no eixo X
largura = 0.35  # Largura das barras
fig, ay = plt.subplots() # Criação do gráfico
barras1 = ay.bar(y - largura/2, values1, largura, label='Draft', color='skyblue')
barras2 = ay.bar(y + largura/2, values2, largura, label='Whole', color='salmon')
# Personalização do gráfico
ay.set_xlabel('M. hyopneumoniae strains')
ay.set_ylabel('Scaffolds')
ay.set_title('Gráfico de Barras Lado a Lado')
ay.set_xticks(y)
ay.set_xticklabels(category, rotation=45, ha='right')
ay.tick_params(axis='x', labelsize=10)
ay.legend()

plt.show() #plt.tight_layout()
'''

import pylustrator
import matplotlib.pyplot as plt
import numpy as np

# Ativar o pylustrator
pylustrator.start()

# Dados de exemplo
x = np.linspace(0, 10, 100)
y1 = np.sin(x)
y2 = np.cos(x)

# Criar uma figura com subplots
fig, axs = plt.subplots(2, 2, figsize=(10, 8))

# Primeiro gráfico
axs[0, 0].plot(x, y1, label="Seno")
axs[0, 0].set_title("Gráfico 1")
axs[0, 0].legend()

# Segundo gráfico
axs[0, 1].plot(x, y2, label="Cosseno", color="red")
axs[0, 1].set_title("Gráfico 2")
axs[0, 1].legend()

# Terceiro gráfico
axs[1, 0].plot(x, y1 * y2, label="Seno * Cosseno", color="green")
axs[1, 0].set_title("Gráfico 3")
axs[1, 0].legend()

# Quarto gráfico
axs[1, 1].plot(x, y1 - y2, label="Seno - Cosseno", color="purple")
axs[1, 1].set_title("Gráfico 4")
axs[1, 1].legend()

# Ajustar espaçamento entre subplots
plt.tight_layout()

# Quando o script é executado, a janela do pylustrator é aberta.
plt.show()

# Salvar a configuração final interativa:
# pylustrator.export("output_figure.png")  # Salva como PNG
