#!/bin/bash

#conda init bash

# # # # #

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
pcR=/home/regenera/
direc_mhp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae
direc_mfc=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare
mhp_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/
mfc_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/
mhp_table=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt
mfc_table=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

# # # DATA COLLECT # # #

e=$(jq '.results."Complete percentage"' short_summary.specific.mycoplasmatales_odb10.busco_complete.json)

mkdir -p ${direc_mfc}/stats_DtC/

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

# FROM BUSCO

# "Complete percentage"

category=()
values1=()
values2=()

for i in "${complete[@]}"; do
    cat=$i
    val1=$(awk -F'\t' 'NR>1 {print $8}' ${mfc_strains}${i}/Use/busco_complete/transposed_report.tsv)
    val2=$(awk -F'\t' 'NR>1 {print $8}' ${mfc_strains}${i}/Use/busco_complete/transposed_report.tsv)

    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done

for i in "${uncomplete[@]}"; do
    # Data: Scaffold | Lenght | GC content
    # Quast draft
    # coluna 2 > Quantity Scaffold
    cat=$i
    val1=$(awk -F'\t' 'NR>1 {print $8}' ${mfc_strains}${i}/Use/quast_draft/transposed_report.tsv)
    val2=$(awk -F'\t' 'NR>1 {print $8}' ${mfc_strains}${i}/Use/quast_complete/transposed_report.tsv)

    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done

echo "${category[@]}"
echo "${values1[@]}"
echo "${values2[@]}"

tsv_line=$(printf "%s\t" "${category[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" > ${direc_mfc}/stats_DtC/totalleght.tsv

tsv_line=$(printf "%s\t" "${values1[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mfc}/stats_DtC/totalleght.tsv

tsv_line=$(printf "%s\t" "${values2[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mfc}/stats_DtC/totalleght.tsv

#############

# coluna 8 > Total lenght
# coluna 17 > Conteúdo GC

