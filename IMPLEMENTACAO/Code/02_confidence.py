# # #

# Nome do arquivo
arquivo = "IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/11/Use/ragtag/ragtag_scaffold/out02/ragtag.scaffold.confidence.txt"
'''
# Inicializa a soma
soma = 0.0

# Abre o arquivo e processa linha a linha
with open(arquivo, "r") as f:
    for linha in f:
        # Divide a linha em colunas
        colunas = linha.split()
        for valor in colunas:
            # Verifica se é um número em ponto flutuante
            try:
                soma += float(valor)
            except ValueError:
                pass  # Ignora valores que não são números

# Exibe a soma total
print(f"Soma total dos números flutuantes: {soma}")
'''
# # # 
'''
import os

# Lista de arquivos para processar (adicione aqui os nomes dos arquivos)
arquivos = ["IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/11/Use/ragtag/ragtag_scaffold/out02/ragtag.scaffold.confidence.txt", "IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/11/Use/ragtag/ragtag_scaffold/out01/ragtag.scaffold.confidence.txt"]

# Nome do arquivo de saída
arquivo_saida = "resultados_soma.txt"

# Dicionário para armazenar resultados
resultados = {}

# Processa cada arquivo
for arquivo in arquivos:
    soma = 0.0
    try:
        with open(arquivo, "r") as f:
            for linha in f:
                # Divide a linha em colunas
                colunas = linha.split()
                for valor in colunas:
                    try:
                        soma += float(valor)  # Soma valores flutuantes
                    except ValueError:
                        pass  # Ignora valores não numéricos
        resultados[arquivo] = soma
    except FileNotFoundError:
        resultados[arquivo] = "Arquivo não encontrado"

# Salva os resultados no arquivo de saída
with open(arquivo_saida, "w") as f:
    for arquivo, soma in resultados.items():
        f.write(f"{arquivo}: {soma}\n")

print(f"Resultados salvos em '{arquivo_saida}'!")

'''

# Lista de arquivos para processar (adicione aqui os nomes dos arquivos)
arquivos = ["IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/11/Use/ragtag/ragtag_scaffold/out02/ragtag.scaffold.confidence.txt", "IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/11/Use/ragtag/ragtag_scaffold/out01/ragtag.scaffold.confidence.txt"]

# Variáveis para armazenar o arquivo com maior soma
arquivo_maior_soma = None
maior_soma = -float('inf')  # Começa com o menor valor possível

# Processa cada arquivo
for arquivo in arquivos:
    soma = 0.0
    try:
        with open(arquivo, "r") as f:
            for linha in f:
                # Divide a linha em colunas
                colunas = linha.split()
                for valor in colunas:
                    try:
                        soma += float(valor)  # Soma valores flutuantes
                    except ValueError:
                        pass  # Ignora valores não numéricos
        # Compara e atualiza o arquivo com maior soma
        if soma > maior_soma:
            maior_soma = soma
            arquivo_maior_soma = arquivo
    except FileNotFoundError:
        print(f"Arquivo não encontrado: {arquivo}")

# Salva o arquivo com maior soma em um arquivo de saída
if arquivo_maior_soma:
    with open("maior_soma.txt", "w") as f:
        f.write(f"Arquivo com maior soma: {arquivo_maior_soma}\n")
        f.write(f"Maior soma: {maior_soma}\n")

    print(f"Resultado salvo em 'maior_soma.txt':\n{arquivo_maior_soma} com soma {maior_soma}")
else:
    print("Nenhum arquivo foi processado.")
