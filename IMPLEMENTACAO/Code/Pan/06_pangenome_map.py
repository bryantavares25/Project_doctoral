'''from collections import defaultdict

# Dados de entrada (substitua por leitura de arquivo, se necessário)
dados = ["WP_002557814\tGO:0003735,GO:0005840,GO:0006412", "WP_002557814\tGO:0003735,GO:0005840,GO:0006412", "WP_002557578\tGO:0005886,GO:0008961,GO:0042158,GO:0042159", "WP_002557578\tGO:0005886,GO:0008961,GO:0042158"]

def parse_dados(dados):
    linhas = dados.strip().split("\n")
    registros = defaultdict(set)
    
    for linha in linhas:
        partes = linha.split("\t")
        id_seq = partes[0]
        go_terms = partes[-2]
        if go_terms != "-":
            registros[id_seq].update(go_terms.split("|"))
    
    return registros

def imprimir_resultado(registros):
    for id_seq, go_terms in registros.items():
        print(f"{id_seq}\t{'|'.join(sorted(go_terms))}")

# Processa e imprime os dados
registros_agrupados = parse_dados(dados)
imprimir_resultado(registros_agrupados)
'''

from collections import defaultdict

dados = [
    "WP_002557814\tGO:0003735,GO:0005840,GO:0006412",
    "WP_002557814\tGO:0003735,GO:0005840,GO:0006412",
    "WP_002557578\tGO:0005886,GO:0008961,GO:0042158,GO:0042159",
    "WP_002557578\tGO:0005886,GO:0008961,GO:0042158,GO:0042160"
]

go_dict = defaultdict(set)

# Processa os dados e remove redundâncias
for linha in dados:
    id_, go_terms = linha.split("\t")
    go_dict[id_].update(go_terms.split(","))

# Formata a saída
resultado = [f"{id_}\t{','.join(sorted(go_terms))}" for id_, go_terms in go_dict.items()]

# Exibe o resultado
for linha in resultado:
    print(linha)
