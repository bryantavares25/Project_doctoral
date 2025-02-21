import csv
from Bio import SeqIO

#file = "/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/11/GCF_002193015.1/cds_from_genomic.fna"
file = "/home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/ATCC27716/Use/GCF_000367185.1/cds_from_genomic.fna"
fule = "/home/bryan/Documentos/GitHub/Project_doctoral/BIOINFO_TEST/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/protein.faa"

print("S T A R T")

refproteases=["MHP7448_RS00135", "MHP7448_RS00160", "MHP7448_RS00735", "MHP7448_RS00780", "MHP7448_RS00895", "MHP7448_RS00965", "MHP7448_RS01125", "MHP7448_RS01645", "MHP7448_RS01695", "MHP7448_RS01760", "MHP7448_RS01830", "MHP7448_RS01965", "MHP7448_RS02430", "MHP7448_RS02535", "MHP7448_RS02710", "MHP7448_RS02825", "MHP7448_RS02840", "MHP7448_RS02910", "MHP7448_RS03080", "MHP7448_RS03310", "MHP7448_RS03360", "MHP7448_RS03395", "MHP7448_RS03465", "MHP7448_RS03555", "MHP7448_RS03865", "MHP7448_RS03870", "MHP7448_RS04050"]

'''
data=[]
for r in refproteases:
    for i in SeqIO.parse(file, "fasta"):
        description = i.description
        if r in description:
            #data=[description.split("[locus_tag=")[1].split("]")[0], description.split("protein=")[1].split("]")[0], description.split("protein_id=")[1].split("]")[0]]
            locus_tag = description.split("[locus_tag=")[1].split("]")[0]
            protein = description.split("protein=")[1].split("]")[0]
            protein_id = description.split("protein_id=")[1].split("]")[0]
            data.append([locus_tag, protein, protein_id])
        
            print(protein_id)
'''
data=[]
for i in SeqIO.parse(file, "fasta"):
    description = i.description
    #data=[description.split("[locus_tag=")[1].split("]")[0], description.split("protein=")[1].split("]")[0], description.split("protein_id=")[1].split("]")[0]]
    #locus_tag = description.split("[locus_tag=")[1].split("]")[0]
    #protein = description.split("protein=")[1].split("]")[0]
    #protein_id = description.split("protein_id=")[1].split("]")[0]
    #data.append([locus_tag, protein, protein_id])
    print(i.id)


#print(data)

print("E N D")

# # # 

'''
data=[]
for i in SeqIO.parse(file, "fasta"):
    #print(i.description)
    description = i.description
    #b = a.split(" ")
    #print(b[-3])

    locus_tag = ""
    protein = ""
    protein_id = ""
    
    # Extrair informações da descrição
    if "locus_tag=" in description:
        locus_tag = description.split("locus_tag=")[1].split("]")[0]
    if "protein=" in description:
        protein = description.split("protein=")[1].split("]")[0]
    if "protein_id=" in description:
        protein_id = description.split("protein_id=")[1].split("]")[0]
    
    # Adicionar os dados à lista
    data.append([locus_tag, protein, protein_id])

print(data)
'''
