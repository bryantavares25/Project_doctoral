import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
from upsetplot import UpSet

# Configurar estilo bonito
sns.set(style="whitegrid", context="talk", font="sans-serif")

# Criando um DataFrame com presença/ausência (1 = presente, 0 = ausente)
df = pd.DataFrame({
    "A": [1, 1, 0, 1, 0, 1, 1, 0, 1, 1],
    "B": [0, 1, 1, 1, 1, 0, 0, 1, 0, 1],
    "C": [1, 0, 1, 1, 0, 1, 0, 1, 0, 1]
})

# Contando a frequência de cada combinação de conjuntos
upset_data = df.groupby(list(df.columns)).size()

# Criando o gráfico UpSet
fig, ax = plt.subplots(figsize=(8, 6), facecolor="white")
upset = UpSet(upset_data, sort_by="cardinality", show_percentages=True)
upset.plot(fig=fig)

# Ajustando título e layout
plt.suptitle("Distribuição de Conjuntos", fontsize=16, fontweight="bold")
plt.subplots_adjust(left=0.1, right=0.9, top=0.9, bottom=0.1)

# Exibir o gráfico
plt.show()
