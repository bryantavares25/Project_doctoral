import pandas as pd
import matplotlib.pyplot as plt
from upsetplot import UpSet, from_indicators

# Criando um DataFrame com as categorias como colunas binárias
data = pd.DataFrame([
    [1, 0, 0, 50],  # Apenas A
    [0, 1, 0, 40],  # Apenas B
    [0, 0, 1, 30],  # Apenas C
    [1, 1, 0, 20],  # A e B
    [1, 0, 1, 10],  # A e C
    [0, 1, 1, 5],   # B e C
    [1, 1, 1, 2],   # A, B e C
], columns=["A", "B", "C", "value"])

# Convertendo para o formato esperado pelo UpSet
data = data.set_index(["A", "B", "C"])["value"]

# Criando o gráfico UpSet
upset = UpSet(data, subset_size="count", show_percentages=True)
upset.plot()

# Exibir o gráfico
plt.show()
