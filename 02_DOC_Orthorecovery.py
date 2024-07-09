# RECOVERY NUCLEOTIDES

# # # LYBRARIES # # #
from Bio import SeqIO

# # # FUNCTIONS # # #

# Function definition
def extract_region(fasta_file, start, end):
    sequences = []
    for record in SeqIO.parse(fasta_file, "fasta"):
        sub_sequence = record.seq[start-1:end]  # Ajuste para a contagem baseada em 0
        sequences.append((record.id, sub_sequence))
    return sequences

# # # EXECUTION # # #

# Parâmetros
fasta_file = "home/lgef/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/GCF_000008225.1_ASM822v1_genomic.fna"   # Arquivo FASTA de entrada
start = 100 # Posição inicial (inclusive)
end = 150 # Posição final (inclusive)

# Extrair a região específica
extracted_sequences = extract_region(fasta_file, start, end)

# Imprimir as sequências extraídas
for seq_id, sequence in extracted_sequences:
    print(f">{seq_id}\n{sequence}")
#print(extracted_sequences)

# END ------------------------------------

# # # B A R T # # #