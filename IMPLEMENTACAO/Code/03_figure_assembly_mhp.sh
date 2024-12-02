#!/bin/bash

conda init bash

# # # # #

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
direc_mhp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/
direc_mfc=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/
mhp_strains=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/
mfc_strains=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/
mhp_table=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt
mfc_table=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

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

uncomplete=(ATCC27716)

categoria=()
valores_1=()
valores_2=()

for i in "${uncomplete[@]}"; do
    # Data: Scaffold | Lenght | GC content
    # Quast draft
    # coluna 2 > Quantity Scaffold
    categoria+=($i)
    valores_1=$(awk -F'\t' '{print $2}' quast_draft=${mfc_strains}${file}/Use/quast_draft/transposed_report.tsv)
    valores_2=$(awk -F'\t' '{print $2}' quast_draft=${mfc_strains}${file}/Use/quast_complete/transposed_report.tsv)
done

echo $categoria
echo $valores_1
echo $valores_2
    


# coluna 8 > Total lenght
# coluna 17 > Conteúdo GC 