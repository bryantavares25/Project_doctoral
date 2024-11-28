# # #

# import pylustrator

# FIGURA 1

'''Figura 1 - Comparar propriedades genômicos para avaliar os genomas completos e os genomas completados.
Propriedades:
    - Conteúdo GC 
    - Completude Busco Result
    - Cromossomos
    - Tamanho
    - Quantidade de Ns
'''

import matplotlib.pyplot as plt

# Dados para o gráfico
categorias = ['A', 'B', 'C', 'D']
valores = [10, 20, 15, 25]

# Criando o gráfico de barras
plt.bar(categorias, valores, color='blue')

# Personalização do gráfico
plt.title('Gráfico de Barras com Matplotlib')
plt.xlabel('Categorias')
plt.ylabel('Valores')

# Exibindo o gráfico
plt.show()
