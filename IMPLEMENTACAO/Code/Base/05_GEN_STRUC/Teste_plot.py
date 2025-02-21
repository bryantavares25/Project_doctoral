import pandas as pd
import matplotlib.pyplot as plt
from upsetplot import UpSet

# Configurar estilo bonito
#sns.set(style="whitegrid", context="talk", font="sans-serif")

# Criando um DataFrame binário (1 = presente, 0 = ausente)
df = pd.DataFrame({
    "M ATCC27716": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0],
    "M MF11": [1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0],
    "M MF18": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0],
    "M MF22": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0],
    "M MF29": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0],
    "M MF30": [0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0],
    "M MF33": [1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0],
    "M 42": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,0]
})

print(df)
#upset_data = df.columns() #.groupby(list(df.columns)).size()
upset_data = df.groupby(list(df.columns)).size().reset_index(name="count")
# Exibir corretamente os resultados
print(upset_data)

#upset_data = df.groupby(df.columns)#.size() #.groupby(list(df.columns)).size()

# Criando o gráfico UpSet
fig, ax = plt.subplots(figsize=(8, 6), facecolor="white")

upset = UpSet(upset_data, sort_categories_by="-input")
#upset.style_subsets(min_subset_size=1, edgecolor="white", linewidth=0.1)

upset.plot(fig=fig)
plt.show()
