import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from upsetplot import UpSet

# Configurar estilo bonito
sns.set(style="whitegrid", context="talk", font="sans-serif")

# Criando um DataFrame binário (1 = presente, 0 = ausente)
df = pd.DataFrame({
    "A": [1, 1, 0, 1, 0, 1, 1, 0, 1, 1],
    "B": [0, 1, 1, 1, 1, 0, 0, 1, 0, 1],
    "C": [1, 0, 1, 1, 0, 1, 0, 1, 0, 1]
})

# Contando a frequência de cada combinação de conjuntos
upset_data = df.groupby(list(df.columns)).size()

# Criando o gráfico UpSet
fig, ax = plt.subplots(figsize=(8, 6), facecolor="white")

upset = UpSet(upset_data)
upset.style_subsets(min_subset_size=1, edgecolor="white", linewidth=0.1)

# Removendo as linhas de conexão
for ax in plt.gcf().axes:  
    for line in ax.get_lines():  
        line.remove()  # Remove as linhas do gráfico
upset.plot(fig=fig)

# Ajustando título
plt.suptitle("UpSet sem Linhas de Conexão", fontsize=16, fontweight="bold")

# Exibir o gráfico
plt.show()
