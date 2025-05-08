# # # 
# # # SELECIONAR GC_GROUPS
# # #

import csv

# Lista de IDs desejados
ids_desejados = ["GC_00000001", "GC_00000002"]

# Abrir o arquivo de entrada
f = open("arquivo.txt")
linhas_filtradas = [
    linha.strip().split()
    for linha in f
    if any(linha.startswith(id_) for id_ in ids_desejados)
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
