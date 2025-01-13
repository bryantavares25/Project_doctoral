#!/bin/bash


# # # # #

# Organization

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
direc_mhp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/
direc_mfc=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/
mhp_table=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt
mfc_table=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

# In collumn
awk -F '\t' 'NR > 1 && !seen[$5]++ {print $5}' "$mhp_table" > "$mhp_list"
awk -F '\t' 'NR > 1 && !seen[$5]++ {print $5}' "$mfc_table" > "$mfc_list"

# Create folder by species
while IFS= read -r line; do a=$line; mkdir -p ${direc_mhp}strains/${a}/Use; done < "$mhp_list"
while IFS= read -r line; do a=$line; mkdir -p ${direc_mfc}strains/${a}/Use; done < "$mfc_list"

# Move files
while IFS= read -r line; do
    a=$line
    echo $a
    awk -v id="$a" '$5 == id {print $1}' "$mhp_table" > "$mhp_temp"
    while IFS= read -r line; do
        b=$line
        echo $b
        mv ${direc_mhp}${b} ${direc_mhp}strains/${a}
    done < "$mhp_temp"
done < "$mhp_list"

while IFS= read -r line; do
    a=$line
    echo $a
    awk -v id="$a" '$5 == id {print $1}' "$mfc_table" > "$mfc_temp"
    while IFS= read -r line; do
        b=$line
        echo $b
        mv ${direc_mfc}${b} ${direc_mfc}strains/${a}
    done < "$mfc_temp"
done < "$mfc_list"
