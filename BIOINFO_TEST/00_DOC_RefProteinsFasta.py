# # # # # # # # # D O C # # # # # # # # #

# RECOVERY BRUTE DATA TO CLEANED DATA
# .gtf input to .tsv output
# Recovery data: scaffold | start nucl | end nucl | strand | protein id code | gene id code  

# # # LYBRARIES # # #
import csv
from Bio import SeqIO

# # # FUNCTIONS # # #
# Function definition
def tsv_read(refproteases, archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        if (line[1] == 'Protein Homology' or line[1] == "GeneMarkS-2+") and line[8].split(';')[1].split("-")[1] in refproteases:
            data.append(line[8].split(';')[0].split("-")[1])
    print(data)
    return data
# Function definition
def fasta_read(data, file_fasta):
    features = []
    for feature in SeqIO.parse(file_fasta, "fasta"):
        if feature.id in data:
            print(feature.id)
            features.append({"id" : feature.id, "des" : feature.description, "seq" : feature.seq})
    return features    
# Function definition
def fasta_create(features, file_output):
    file_output = open(file_output, "w")
    for feature in features:
        print(feature)
        file_output.write(f'>{feature['id']}\n{feature['seq']}\n')
    file_output.close()

# # # EXECUTION # # #

print(" - - - START - - -")
# Input tsv
file_input = "/home/bryan/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_cleaned.gff"
refproteases=["MHP7448_RS00135", "MHP7448_RS00160", "MHP7448_RS00735", "MHP7448_RS00780", "MHP7448_RS00895", "MHP7448_RS00965", "MHP7448_RS01125", "MHP7448_RS01645", "MHP7448_RS01695", "MHP7448_RS01760", "MHP7448_RS01830", "MHP7448_RS01965", "MHP7448_RS02430", "MHP7448_RS02535", "MHP7448_RS02710", "MHP7448_RS02825", "MHP7448_RS02840", "MHP7448_RS02910", "MHP7448_RS03080", "MHP7448_RS03310", "MHP7448_RS03360", "MHP7448_RS03395", "MHP7448_RS03465", "MHP7448_RS03555", "MHP7448_RS03865", "MHP7448_RS03870", "MHP7448_RS04050"]
data = tsv_read(refproteases, file_input)
# Input fasta
fasta_input = "/home/bryan/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/protein.faa"
features = fasta_read(data, fasta_input)
# Output creation
file_output = "/home/bryan/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/REF_FASTA.fasta"
fasta_create(features, file_output)
#print(" - - - FINISHED - - - ")

# END ------------------------------------

# # # B A R T # # #