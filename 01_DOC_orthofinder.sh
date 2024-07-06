#!/bin/bash

genomesmhp=(MHP_11 MHP_98 MHP_168 MHP_168L MHP_232 MHP_7422 MHP_7448 MHP_ES2 MHP_ES2L MHP_F72C MHP_J MHP_LH MHP_MHP650 MHP_MHP653 MHP_MHP679 MHP_MHP682 MHP_MHP691 MHP_MHP694 MHP_MHP696 MHP_MHP699 MHP_MHP709 MHP_NCTC10127 MHP_TB1 MHP_UFV01 MHP_UFV02)
genomesmfc=(MFC_ATCC27716 MFC_MF11 MFC_MF18 MFC_MF22 MFC_MF29 MFC_MF30 MFC_MF33 MFC_Ms42)
direc="/home/lgef/Documentos/GitHub/Project_doctoral/"

#f="/home/lgef/Documentos/GitHub/Project_doctoral/Orthofinder_db"

# Search MHP
for genome in "${genomesmhp[@]}"; do cp ${direc}Genomes/Mesomycoplasma_hyopneumoniae/${genome}/ncbi_dataset/data/*/protein.faa ${direc}Orthofinder_db/${genome}_proteins_fasta; done
# Search MFC
for genome in "${genomesmfc[@]}"; do cp ${direc}Genomes/Mesomycoplasma_flocculare/${genome}/ncbi_dataset/data/*/protein.faa ${direc}Orthofinder_db/${genome}_proteins_fasta; done
