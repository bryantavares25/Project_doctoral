# # # # # ProtRetrieval # # # # # 

# Importar biblioteca
from Bio import SeqIO


def ler_fasta(caminho_do_arquivo):
    sequencias = []
    for sequencia in SeqIO.parse(caminho_do_arquivo, "fasta"):
        sequencias.append({"id": sequencia.id, "descricao": sequencia.description, "sequencia": sequencia.seq})
    return sequencias

# Exemplo de uso:
caminho_arquivo = "teste.fasta"
sequencias_fasta = ler_fasta(caminho_arquivo)

# Exibindo as sequências lidas
for sequencia in sequencias_fasta:
    print("ID:", sequencia["id"])
    print("Descrição:", sequencia["descricao"])
    print("Sequência:", sequencia["sequencia"])

def extrair_parte_da_sequencia(caminho_do_arquivo, start, end):
    with open(caminho_do_arquivo, "r") as handle:
        for sequencia in SeqIO.parse(handle, "fasta"):
            parte_da_sequencia = sequencia.seq[start-1:end]  # As posições em Python começam em 0, então subtrai 1 de 'start'
            return str(parte_da_sequencia)

# Exemplo de uso:
caminho_arquivo = "teste.fasta"
posicao_final = 5
posicao_inicial = posicao_final-2
parte_selecionada = extrair_parte_da_sequencia(caminho_arquivo, posicao_inicial, posicao_final)
print("Parte da sequência selecionada:", parte_selecionada)

# 01 Step

# Input > cds position or cds id

# Output >  cds.fasta

# 02 Step

# Output upstream.fasta

# 03 Step

# Output downstream.fasta

# # # B. A. R. T. # # #