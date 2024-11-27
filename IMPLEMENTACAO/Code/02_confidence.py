# # #

# Folders
pcH='/home/bryan/'
pcL='/home/lgef/'
mhp_strains=f'{pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/'
mfc_strains=f'{pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MFC_ncbi_dataset/ncbi_dataset/data/strains/'

# Lista de arquivos para processar (adicione aqui os nomes dos arquivos)
arquivos = ["IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/11/Use/ragtag/ragtag_scaffold/out02/ragtag.scaffold.confidence.txt", "IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/11/Use/ragtag/ragtag_scaffold/out01/ragtag.scaffold.confidence.txt"]

# Variáveis para armazenar o arquivo com maior soma
arquivo_maior_soma = None
maior_soma = -float('inf')  # Começa com o menor valor possível

# Processa cada arquivo
for arquivo in arquivos:
    soma = 0.0
    # Abre o arquivo manualmente
    f = open(arquivo, "r")
    for linha in f:
        # Divide a linha em colunas
        colunas = linha.split()
        for valor in colunas:
            try:
                soma += float(valor)  # Soma valores flutuantes
            except ValueError:
                pass  # Ignora valores não numéricos
    f.close()  # Fecha o arquivo

    # Compara e atualiza o arquivo com maior soma
    if soma > maior_soma:
        maior_soma = soma
        arquivo_maior_soma = arquivo

# Salva o arquivo com maior soma em um arquivo de saída
if arquivo_maior_soma:
    f_saida = open("maior_soma.txt", "w")
    f_saida.write(f"Arquivo com maior soma: {arquivo_maior_soma}\n")
    f_saida.write(f"Maior soma: {maior_soma}\n")
    f_saida.close()  # Fecha o arquivo de saída

    print(f"Resultado salvo em 'maior_soma.txt':\n{arquivo_maior_soma} com soma {maior_soma}")
else:
    print("Nenhum arquivo foi processado.")

