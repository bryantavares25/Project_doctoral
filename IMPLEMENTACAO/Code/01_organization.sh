#!/bin/bash

# # # # #

# Organization USE

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
direc_mhp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/
direc_mfc=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/
mhp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/
mfc=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/
mhp_table=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt
mfc_table=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

for file in $(cat "$mhp_list"); do
    if ls ${mhp}${file}/GCF* 1> /dev/null 2>&1; then
        cp -r ${mhp}${file}/GCF* ${mhp}${file}/Use/
    elif ls ${mhp}${file}/GCA* 1> /dev/null 2>&1; then
        cp -r ${mhp}${file}/GCA* ${mhp}${file}/Use/
    else
        echo "Nenhum arquivo GCF ou GCA encontrado."
    fi
done

for file in $(cat "$mfc_list"); do
    if ls ${mfc}${file}/GCF* 1> /dev/null 2>&1; then
        cp -r ${mfc}${file}/GCF* ${mfc}${file}/Use/
    elif ls ${mfc}${file}/GCA* 1> /dev/null 2>&1; then
        cp -r ${mfc}${file}/GCA* ${mfc}${file}/Use/
    else
        echo "Nenhum arquivo GCF ou GCA encontrado."
    fi
done
