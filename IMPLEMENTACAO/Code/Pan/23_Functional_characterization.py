# # # 
# # # SELECIONAR GC_GROUPS
# # #

import csv

# Lista de IDs desejados
# MHP
ids = [] # CORE
ids = [] # CORE > Single-copie genes
ids = [] # CORE > Multiple-copie genes
ids = [] # SHELL
ids = [] # SHELL > Cloud 
ids = [] # SHELL > Singletons

#MFC
ids = [] # CORE
ids = [] # CORE > Single-copie genes
ids = [] # CORE > Multiple-copie genes
ids = [] # SHEL
ids = [] # SHEL > Cloud
ids = [] # SHEL > Singletons

#MHP-MFC
ids = [] # CORE
ids = [] # CORE > Single-copie genes
ids = [] # CORE > Multiple-copie genes
ids = [] # SHEL
ids = [] # SHEL > Cloud
ids = [] # SHEL > Singletons

# Abrir o arquivo de entrada
f = open("arquivo.txt")
linhas_filtradas = [
    linha.strip().split()
    for linha in f
    if any(linha.startswith(id) for id in ids)
]
f.close()

# Escrever em um novo CSV
csvfile = open("saida_filtrada.csv", "w", newline="")
writer = csv.writer(csvfile)
writer.writerow(["ID", "GO"])  # Cabeçalho
writer.writerows(linhas_filtradas)
csvfile.close()

# # #
# # #
