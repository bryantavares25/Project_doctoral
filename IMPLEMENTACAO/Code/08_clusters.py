

import csv
from Bio import SeqIO

file = "/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/11/GCF_002193015.1/cds_from_genomic.fna"

print("S T A R T")

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
        locus_tag = description.split("[locus_tag=")[1].split("]")[0]
    if "protein=" in description:
        protein = description.split("[protein=")[1].split("]")[0]
    if "protein_id=" in description:
        protein_id = description.split("[protein_id=")[1].split("]")[0]
    
    # Adicionar os dados à lista
    data.append([locus_tag, protein, protein_id])

print(data)

print("E N D")