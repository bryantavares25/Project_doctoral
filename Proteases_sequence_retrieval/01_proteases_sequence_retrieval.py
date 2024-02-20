# # # ProtRetrieval # # # 

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

# 01 Step

# Input > cds position or cds id

# Output >  cds.fasta

# 02 Step

# Output upstream.fasta

# 03 Step

# Output downstream.fasta

# # # B. A. R. T. # # #