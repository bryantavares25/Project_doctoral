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
mhp_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/
mfc_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MFC_ncbi_dataset/ncbi_dataset/data/strains/

for file in $(cat "$mhp_list"); do
    result=$(awk -v id="$file" '$5 == id && $0 ~ /Complete/ {print $5}' "$mhp_table")
    if [ -n "$result" ]; then found=true; else found=false; fi
    echo $file $found

'''
conda init bash
conda activate busco
busco -i /home/lgef/Documentos/GitHub/Project_doctoral/BIOINFO_TEST/MHP_7448_dataset/ncbi_dataset/data/GCF_000008225.1/GCF_000008225.1_ASM822v1_genomic.fna -l mycoplasmatales_odb10 -m genome -o BUSCO_OUTPUT
conda deactivate
'''

    if ["$found"==true]; then # COMPLETE
        conda activate busco
        cd ${mhp_strains}${file}Use/
        busco -i ${mhp_strains}${file}Use/G*/G*.fna -m genome -l mycoplasmatales_odb10 -o busco_complete
        cd ..
        conda deactivate

        conda activate quast
        quast ${mhp_strains}${file}Use/G*/G*.fna -o ${mhp_strains}${file}Use/quast_complete
        conda deactivate quast

    elif ["$found"==false]; then # DRAF
        conda activate busco
        cd ${mhp_strains}${file}Use/
        busco -i ${mhp_strains}${file}Use/G*/G*.fna -m genome -l mycoplasmatales_odb10 -o busco_draft
        cd ..
        conda deactivate

        conda activate quast
        quast ${mhp_strains}${file}Use/G*/G*.fna -o ${mhp_strains}${file}Use/quast_draft
        conda deactivate quast

        ### RAGTAG     
        conda activate ragtag
        # Scafold
        ragtag.py scaffold "${seqid[@]}" ${direc}${i}/06_seq_sca/**** -o ${direc}${i}/10_ref_ass/ragtag_scaffold/
        # Merge
        ragtag.py patch "${seqid[@]}" ${direc}${i}/10_ref_ass/ragtag_scaffold/**** -o ${direc}${i}/10_ref_ass/ragtag_patch/ done
        # Patch
        ragtag.py patch "${seqid[@]}" ${direc}${i}/10_ref_ass/ragtag_scaffold/**** -o ${direc}${i}/10_ref_ass/ragtag_patch/ done
        conda deactivate

        conda activate busco
        cd ${mhp_strains}${file}Use/
        busco -i ${mhp_strains}${file}Use/G*/G*.fna -m genome -l mycoplasmatales_odb10 -o busco_complete
        cd ..
        conda deactivate

        conda activate quast
        quast ${mhp_strains}${file}Use/G*/G*.fna -o ${mhp_strains}${file}Use/quast_complete
        conda deactivate quast
    else
        echo "ERRO"
done