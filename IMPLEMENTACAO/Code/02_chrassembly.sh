#!/bin/bash

conda init bash


# # # # #

# Organization USE

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
direc_mhp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/
direc_mfc=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/MFC_ncbi_dataset/ncbi_dataset/data/
mhp_table="IMPLEMENTACAO/Genomes/mhp_table.tsv" # Curadoria manual
mhp_list="IMPLEMENTACAO/Genomes/mhp_list.txt"
mhp_temp="IMPLEMENTACAO/Genomes/mhp_result.txt"
mfc_table="IMPLEMENTACAO/Genomes/mfc_table.tsv" # Curadoria manual
mfc_list="IMPLEMENTACAO/Genomes/mfc_list.txt"
mfc_temp="IMPLEMENTACAO/Genomes/mfc_result.txt"


for file in $(cat "$mhp_list")

# COMPLETE
conda activate busco
busco /final.contigs.fa -m genome -o /07_val_sca
conda deactivate

# DRAF
conda activate busco
busco /final.contigs.fa -m genome -o /07_val_sca
conda deactivate

conda activate ragtag
ragtag.py scaffold "${seqid[@]}" ${direc}${i}/06_seq_sca/**** -o ${direc}${i}/10_ref_ass/ragtag_scaffold/
ragtag.py patch "${seqid[@]}" ${direc}${i}/10_ref_ass/ragtag_scaffold/**** -o ${direc}${i}/10_ref_ass/ragtag_patch/ done
conda deactivate

conda activate busco
busco /final.contigs.fa -m genome -o /07_val_sca
conda deactivate