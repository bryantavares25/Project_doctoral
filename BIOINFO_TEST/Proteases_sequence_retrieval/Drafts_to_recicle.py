import csv

nome_arquivo = 'teste.csv'

# Lista onde vamos armazenar os dados lidos do arquivo CSV
lista_de_dados = []

# Ler o arquivo CSV
with open(nome_arquivo, 'r') as arquivo_csv:
    leitor_csv = csv.reader(arquivo_csv)
    for linha in leitor_csv:
        lista_de_dados.append(linha)

# Exibir os dados lidos
for linha in lista_de_dados:
    print(linha)


# Lista de dados que queremos escrever no arquivo CSV
'''lista_de_dados = [
    ['CSD_01', 'Label',  'Features'],
    ['CSD_02', 'Label',  'Features'],
    ['CSD_03', 'Label',  'Features'],
    ['CSD_04', 'Label',  'Features'],
    ['CSD_05', 'Label',  'Features']
    ]

# Nome do arquivo CSV que será criado
nome_arquivo = 'dados.csv'

# Escrever os dados no arquivo CSV
with open(nome_arquivo, 'w', newline='') as arquivo_csv:
    escritor_csv = csv.writer(arquivo_csv)
    escritor_csv.writerows(lista_de_dados)

print(f'O arquivo "{nome_arquivo}" foi criado com sucesso!')'''


'''dn = {'A': [1, 0, 0, 0], 'T': [0, 1, 0, 0], 'C': [0, 0, 1, 0], 'G': [0, 0, 0, 1]}

seqtest = 'GAAAAATCTCG'
c_seqtest = []

for i in range(len(seqtest)):
    print(seqtest[i])

    convertido = seqtest[i]
    a = dn[convertido]

    c_seqtest.append(a)

print(c_seqtest)

print('Finalizado')'''