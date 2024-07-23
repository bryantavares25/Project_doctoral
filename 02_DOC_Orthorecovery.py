# RECOVERY NUCLEOTIDES

# # # LYBRARIES # # #
from Bio import SeqIO
import csv

# # # FUNCTIONS # # #

# Function definition - READ FASTA
def fasta_read(file_fasta):
    features = []
    for feature in SeqIO.parse(file_fasta, "fasta"):
        #if feature.id in data:
        features.append({"id" : feature.id, "des" : feature.description, "seq" : feature.seq})
    print(features)
    return features
# Function definition
def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
            data.append(line)
    return data
# Function definition
def tsv_write(archive):
    write_tsv_archive = open(archive,"w")
    for line in data:
        for i in line:
            write_tsv_archive.write(f"{i}\t")
        write_tsv_archive.write(f"\n")
    write_tsv_archive.close()
# Function definition
def extract_region(fasta_file, start, end, nc):
    sequences = []
    for record in SeqIO.parse(fasta_file, "fasta"):
        if record.id == nc:
            #sub_sequence = record.seq[start-250:start+50]
            sub_sequence = record.seq[start-251:start+49]
            sequences.append((record.id, sub_sequence))
    return sequences

# # # EXECUTION # # #

# RECOVERY NUCLEOTYDE SEQUENCE

# TESTE
input = "MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/REF_genomic_gff_cleaned.tsv"
data=tsv_read(input)

for i in data: 
    print(i)
    fasta_file = "/home/lgef/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/GCF_000008225.1_ASM822v1_genomic.fna"   # Arquivo FASTA de entrada
#fasta_file = "TESTE.fasta"
#start = 5 # Posição inicial (inclusive)
#end = 15 # Posição final (inclusive)
    start = int(i[1])
    end = int(i[2])
    nc = i[0]
#fcar = fasta_read(fasta_file)
    extracted_sequences = extract_region(fasta_file, start, end, nc)
# Imprimir as sequências extraídas

    for seq_id, sequence in extracted_sequences:
        print(f">{seq_id}\n{sequence}")
    print(extracted_sequences)

# END ------------------------------------

# # # B A R T # # #