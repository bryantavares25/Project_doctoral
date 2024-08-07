#!/bin/bash

genomesmhp=(MHP_11 MHP_98 MHP_168 MHP_168L MHP_232 MHP_7422 MHP_7448 MHP_ES2 MHP_ES2L MHP_F72C MHP_J MHP_LH MHP_MHP650 MHP_MHP653 MHP_MHP679 MHP_MHP682 MHP_MHP691 MHP_MHP694 MHP_MHP696 MHP_MHP699 MHP_MHP709 MHP_NCTC10127 MHP_TB1 MHP_UFV01 MHP_UFV02)
genomesmfc=(MFC_ATCC27716 MFC_MF11 MFC_MF18 MFC_MF22 MFC_MF29 MFC_MF30 MFC_MF33 MFC_MS42)

direc="/home/bryan/Documentos/GitHub/Project_doctoral/"
#direc="/home/lgef/Documentos/GitHub/Project_doctoral/"
#f="/home/lgef/Documentos/GitHub/Project_doctoral/Orthofinder_db"

# # # STEP 0 - Proteins file copy

# Copy MHP
for genome in "${genomesmhp[@]}"; do cd ${direc}Genomes/Mesomycoplasma_hyopneumoniae/${genome}/ncbi_dataset/data/GCF_*.1; cp protein.faa ${genome}_protein.fasta; cd; done
# Copy MFC
for genome in "${genomesmfc[@]}"; do cd ${direc}Genomes/Mesomycoplasma_flocculare/${genome}/ncbi_dataset/data/GCF_*.1; cp protein.faa ${genome}_protein.fasta; cd; done

# # # STEP 1 - Proteins file mv
# Move MHP
for genome in "${genomesmhp[@]}"; do mv ${direc}Genomes/Mesomycoplasma_hyopneumoniae/${genome}/ncbi_dataset/data/GCF_*.1/${genome}_protein.fasta ${direc}Orthofinder_db/; done
# Move MFC
for genome in "${genomesmfc[@]}"; do mv ${direc}Genomes/Mesomycoplasma_flocculare/${genome}/ncbi_dataset/data/GCF_*.1/${genome}_protein.fasta ${direc}Orthofinder_db/; done

# # # STEP 3 - Proteins target
# REF proteases
refproteases=(MHP7448_RS00135 MHP7448_RS00160 MHP7448_RS00735 MHP7448_RS00780 MHP7448_RS00895 MHP7448_RS00965 MHP7448_RS01125 MHP7448_RS01645 MHP7448_RS01695 MHP7448_RS01760 MHP7448_RS01830 MHP7448_RS01965 MHP7448_RS02430 MHP7448_RS02535 MHP7448_RS02710 MHP7448_RS02825 MHP7448_RS02840 MHP7448_RS02910 MHP7448_RS03080 MHP7448_RS03310 MHP7448_RS03360 MHP7448_RS03395 MHP7448_RS03465 MHP7448_RS03555 MHP7448_RS03865 MHP7448_RS03870 MHP7448_RS04050)

# # # # # B A R T # # # # #

# DRAFT

# Remove files
#for genome in "${genomesmhp[@]}"; do rm ${direc}Genomes/Mesomycoplasma_hyopneumoniae/${genome}/ncbi_dataset/data/GCF_*.1/protein01.fasta; done
#for genome in "${genomesmfc[@]}"; do rm ${direc}Genomes/Mesomycoplasma_flocculare/${genome}/ncbi_dataset/data/GCF_*.1/protein01.fasta; done