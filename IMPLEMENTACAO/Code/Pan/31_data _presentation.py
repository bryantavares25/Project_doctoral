#!python3

import pandas as pd

mhp="/home/bryantavares/Documents/GitHub/Project_doctoral/Data/01_MHP_fractions_classified.csv"
mfc="/home/bryantavares/Documents/GitHub/Project_doctoral/Data/01_MFC_fractions_classified.csv"
mx="/home/bryantavares/Documents/GitHub/Project_doctoral/Data/01_MX_fractions_classified.csv"

csv=pd.read_csv(mhp)
df = pd.DataFrame(csv)

filtered = df[
    (df['Distribution layer'] == 'Core') &
    (df['Copy-number class'] == 'Multiple copies-gene')
]
# Obter a lista de gene clusters
gene_clusters = filtered['Gene clusters'].unique().tolist()

pd.DataFrame({'Gene clusters': gene_clusters}).to_csv('gene_clusters_core_multiple_copies.csv', index=False, header=False)

import matplotlib.pyplot as plt

# Exibe a quantidade de gene clusters
print(len(gene_clusters))

# Gera um gráfico de barras com a contagem de gene clusters
plt.bar(['Gene clusters'], [len(gene_clusters)])
plt.ylabel('Quantidade')
plt.title('Quantidade de Gene Clusters (Core, Multiple copies-gene)')
plt.show()


