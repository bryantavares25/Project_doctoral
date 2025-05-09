# # # # # # # # # D O C # # # # # # # # #

# RECOVERY BRUTE DATA TO CLEANED DATA
# .gtf input to .tsv output
# Recovery data: scaffold | start nucl | end nucl | strand | protein id code | gene id code  

# # # LYBRARIES # # #
import csv

# # # FUNCTIONS # # #
# Function definition
def tsv_read(archive):
    data = []
    opened = open(archive, 'r', newline='', encoding='utf-8')
    read_tsv = csv.reader(opened, delimiter='\t')
    for line in read_tsv:
        if line[1] == 'Protein Homology' or line[1] == "GeneMarkS-2+":
            data.append([line[0], line[3], line[4], line[6], line[8].split(';')[0], line[8].split(';')[1]] )
    return data
# Function definition
def tsv_create(data, archive):
    write_tsv_archive = open(archive,"w")
    for line in data:
        for i in line:
            write_tsv_archive.write(f"{i}\t")
        write_tsv_archive.write(f"\n")
    write_tsv_archive.close()

# # # EXECUTION # # #

print(" - - - START - - -")
# Input recipe
file_input = '/home/bryan/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_cleaned.gff'
input = tsv_read(file_input)
# Output creation
file_output = "/home/bryan/Documentos/GitHub/Project_doctoral/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/genomic_gff_cleaned.tsv"
tsv_create(input, file_output)
print(" - - - FINISHED - - - ")

# END ------------------------------------

# # # B A R T # # #