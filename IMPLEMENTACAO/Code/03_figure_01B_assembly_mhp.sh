#!/bin/bash

#conda init bash

# # # # #

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
pcR=/home/regenera/
direc_mhp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae
mhp_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/
mhp_table=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt

# # # DATA COLLECT # # #

mkdir -p ${direc_mhp}/Stats_DtC/

complete=()
uncomplete=()
for file in $(cat $mhp_list); do
    result=$(awk -v id="$file" '($5 == id && ($0 ~ /Complete/ || $0 ~ /Chromosome/)) {print $5}' $mhp_table)
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
category=()
values1=()
values2=()

for i in "${complete[@]}"; do
    # Data: Scaffold | Lenght | GC content
    # Quast draft
    # coluna 2 > Quantity Scaffold
    cat=$i
    val1=0
    val2=$(awk -F'\t' 'NR>1 {print $17}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)

    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done

for i in "${uncomplete[@]}"; do
    # Data: Scaffold | Lenght | GC content
    # Quast draft
    # coluna 2 > Quantity Scaffold
    cat=$i
    val1=$(awk -F'\t' 'NR>1 {print $17}' ${mhp_strains}${i}/Use/quast_draft/transposed_report.tsv)
    val2=$(awk -F'\t' 'NR>1 {print $17}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)

    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done

echo "${category[@]}"
echo "${values1[@]}"
echo "${values2[@]}"

tsv_line=$(printf "%s\t" "${category[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" > ${direc_mhp}/stats_DtC/gccontent.tsv

tsv_line=$(printf "%s\t" "${values1[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_DtC/gccontent.tsv

tsv_line=$(printf "%s\t" "${values2[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_DtC/gccontent.tsv

#############

# coluna 8 > Total lenght
# coluna 17 > Conteúdo GC

