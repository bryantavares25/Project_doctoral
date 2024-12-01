#!/bin/bash

conda init bash

# # # # #

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
direc_mhp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/
direc_mfc=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/MFC_ncbi_dataset/ncbi_dataset/data/
mhp_table=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt
mfc_table="IMPLEMENTACAO/Genomes/mfc_table.tsv" # Curadoria manual
mfc_list="IMPLEMENTACAO/Genomes/mfc_list.txt"
mfc_temp="IMPLEMENTACAO/Genomes/mfc_result.txt"
mhp_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/
mfc_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MFC_ncbi_dataset/ncbi_dataset/data/strains/