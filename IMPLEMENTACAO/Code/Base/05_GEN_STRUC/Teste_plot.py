import pandas as pd
import matplotlib.pyplot as plt
from upsetplot import UpSet

# Definir os dados
dados = {
    "M MF11": [1,1,1,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0],
    "M MF18": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0],
    "M MF22": [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0]
}

# Converter para DataFrame
df = pd.DataFrame(dados)

# Transformar os dados no formato correto para o UpSet plot
#df["value"] = 1  # Criar uma coluna de contagem
df = df.groupby(list(dados.keys())).size().reset_index(name="count")  # Agrupar ocorrências

# Criar o gráfico UpSet
upset = UpSet(df.set_index(list(dados.keys()))["count"], subset_size="count", show_percentages=False)
upset.plot()

# Exibir o gráfico
plt.show()
