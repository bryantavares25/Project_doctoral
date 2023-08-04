# # # # # # Promoter sequence
# Letter to Code

# Importando bibliotecas
import csv

# Lendo arquivo CSV com as sequências
# Lista onde vamos armazenar os dados lidos do arquivo CSV
# Ler o arquivo CSV
nome_arquivo = 'Dados_prontos.csv'
lista_de_dados = []

with open(nome_arquivo, 'r') as arquivo_csv:
    leitor_csv = csv.reader(arquivo_csv)
    for linha in leitor_csv:
        lista_de_dados.append(linha)

super_code = []

# Exibir os dados lidos
# Converter dados lidos
for linha in lista_de_dados:
    cds_nome = linha[0]
    cds_label = linha[1]
    cds_seq = linha[2]

    # Nucleotide sequence to binary code
    a = cds_seq.replace('A', '1000')
    t = a.replace('T', '0100')
    c = t.replace('C', '0010')
    g = c.replace('G', '0001')

    # Colocando cada item da string em um lista 
    code = []
    code.append(cds_nome)
    code.append(cds_label)
    for i in range(len(g)):
        code.append(g[i])

    super_code.append(code)

# Salvar o arquivo
arquivo_novo = 'testes.csv'
with open(arquivo_novo, 'w', newline='') as arquivo_csv:
    escritor_csv = csv.writer(arquivo_csv)
    escritor_csv.writerows(super_code)

print('Finalizado')

# # # # # B.A.R.T. # # # # #

import pandas as pd

# Substitua 'seu_arquivo.csv' pelo caminho do seu arquivo CSV
caminho_arquivo = 'seu_arquivo.csv'

# Carrega o arquivo CSV em um DataFrame
dataframe = pd.read_csv(caminho_arquivo)

# Agora você pode trabalhar com o DataFrame
print(dataframe)

