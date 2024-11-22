import pandas as pd

# Substitua 'seu_arquivo.csv' pelo caminho do seu arquivo CSV
caminho_arquivo = '/kaggle/input/dados-trabalho/testes.csv'

# Carrega o arquivo CSV em um DataFrame
dataframe = pd.read_csv(caminho_arquivo)

# Agora você pode trabalhar com o DataFrame
dataframe.head