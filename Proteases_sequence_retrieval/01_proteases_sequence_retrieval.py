# # # ProtRetrieval # # # 

# Importar biblioteca
from Bio import SeqIO

arquivo_fasta = '/Proteases_sequence_retrieval.py/arquivo.fasta'


# Lê as sequências do arquivo FASTA
for sequencia in SeqIO.parse(arquivo_fasta, 'fasta'):
    print(f'Título: {sequencia.id}')
    print(f'Descrição {sequencia.description}')
    print(f'Sequência: {sequencia.seq}\n')

# 01 Step

# Input > cds position or cds id

# Output >  cds.fasta

# 02 Step

# Output upstream.fasta

# 03 Step

# Output downstream.fasta

# # # B. A. R. T. # # #