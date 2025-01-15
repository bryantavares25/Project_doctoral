#!/bin/bash

direc=/home/lgef
/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/Orthofinder
input_folder=${direc}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/Orthofinder

# Copy MHP
for genome in "${genomesmhp[@]}"; do
    cd ${direc}Genomes/Mesomycoplasma_hyopneumoniae/${genome}/ncbi_dataset/data/GCF_*.1
    cp protein.faa ${genome}_protein.fasta
    cd
done

# Copy MFC
for genome in "${genomesmfc[@]}"; do cd ${direc}Genomes/Mesomycoplasma_flocculare/${genome}/ncbi_dataset/data/GCF_*.1; cp protein.faa ${genome}_protein.fasta; cd; done

# # # STEP 1 - Proteins file mv
# Move MHP
for genome in "${genomesmhp[@]}"; do
    mv ${direc}Genomes/Mesomycoplasma_hyopneumoniae/${genome}/ncbi_dataset/data/GCF_*.1/${genome}_protein.fasta ${direc}Orthofinder_db/
done

# Move MFC
for genome in "${genomesmfc[@]}"; do mv ${direc}Genomes/Mesomycoplasma_flocculare/${genome}/ncbi_dataset/data/GCF_*.1/${genome}_protein.fasta ${direc}Orthofinder_db/; done