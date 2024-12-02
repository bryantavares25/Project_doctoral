#!/bin/bash

conda init bash

# # # # #

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
pcR=/home/regenera/
direc_mhp=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/
direc_mfc=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/
mhp_strains=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/
mfc_strains=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/
mhp_table=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt
mfc_table=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=${pcR}Documents/BART_gitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

# # # DATA COLLECT # # #

complete=()
uncomplete=()
for file in $(cat $mfc_list); do
    result=$(awk -v id="$file" '($5 == id && ($0 ~ /Complete/ || $0 ~ /Chromosome/)) {print $5}' $mfc_table)
    if [ -n "$result" ]; then
        found=true
        complete+=($file)
    else
        found=false
        uncomplete+=($file)
    fi
    echo $file $found
done

# FROM QUAST

uncomplete=(ATCC27716 MF11)

categoria=()
valores_1=()
valores_2=()

for i in "${uncomplete[@]}"; do
    # Data: Scaffold | Lenght | GC content
    # Quast draft
    # coluna 2 > Quantity Scaffold
    cat=$i
    val_1=$(awk -F'\t' 'NR>1 {print $2}' ${mfc_strains}${i}/Use/quast_draft/transposed_report.tsv)
    val_2=$(awk -F'\t' 'NR>1 {print $2}' ${mfc_strains}${i}/Use/quast_complete/transposed_report.tsv)

    categoria+=($cat)
    valores_1+=($val_1)
    valores_2+=($val_2)
done

echo "${categoria[@]}"
echo "${valores_1[@]}"
echo "${valores_2[@]}"

cat_convert=()
for l in "${categoria[@]}"; do
    echo "'${l}', "
    cat_convert+=("'${l}', ")
done

echo "${cat_convert[@]}"

# coluna 8 > Total lenght
# coluna 17 > Conteúdo GC 