# # # # # 

# # # # # L I B R A R I E S

from Bio import SeqIO

# # # # # F U N C T I O N S

def fasta_read(archive):
    features = []
    for feature in SeqIO.parse(archive, "fasta"):
        features.append({"id": feature.id, "des": feature.description, "seq": feature.seq})
    return features

# Function definition
def fasta_create(features_list, file_output):
    file_output = open(file_output, "w")
    for i in features_list:
        #file_output.write(f"{i[1]}\n")
        file_output.write(f">{i[0]}\n{i[1]}\n")
    file_output.close()


# # # # # E X E C U T I O N

print("\n S T A R T E D \n")

# Read FASTA: genome to list

# Data ids 
prot_ids_mhp7448 = ["MHP7448_RS00135", "MHP7448_RS00160", "MHP7448_RS00735", "MHP7448_RS00780", "MHP7448_RS00895", "MHP7448_RS00965", "MHP7448_RS01125", "MHP7448_RS01645", "MHP7448_RS01695", "MHP7448_RS01760", "MHP7448_RS01830", "MHP7448_RS01965", "MHP7448_RS02430", "MHP7448_RS02535", "MHP7448_RS02710", "MHP7448_RS02825", "MHP7448_RS02840", "MHP7448_RS02910", "MHP7448_RS03080", "MHP7448_RS03310", "MHP7448_RS03360", "MHP7448_RS03395", "MHP7448_RS03465", "MHP7448_RS03555", "MHP7448_RS03865", "MHP7448_RS03870", "MHP7448_RS04050"]
genome = "MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/cds_from_genomic.fna"

features = fasta_read(genome)

for i in features:
    for l in prot_ids_mhp7448:
        if l in i["des"]:
            print(f"{i["id"]}")
            print(f"{i["des"]}")
            print(i["seq"])

print("\n F I N I S H E D \n")

# # # # # O B S

# # # # # B. A. R. T. # # # # #