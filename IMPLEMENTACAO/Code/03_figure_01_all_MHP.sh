#!/bin/bash

#conda init bash

# # # # #

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
pcR=/home/regenera/
direc_mhp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae
mhp_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/
mhp_table=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv
mhp_list=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt

# EXECUTION

# # # DATA COLLECT # # #

mkdir -p ${direc_mhp}/stats_dtc/

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

# Total lenght - FROM QUAST
category=()
values1=()
values2=()
for i in "${complete[@]}"; do
    cat=$i
    val1=$(awk -F'\t' 'NR>1 {print $8}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)
    val2=$(awk -F'\t' 'NR>1 {print $8}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)
    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done
for i in "${uncomplete[@]}"; do
    cat=$i
    val1=$(awk -F'\t' 'NR>1 {print $8}' ${mhp_strains}${i}/Use/quast_draft/transposed_report.tsv)
    val2=$(awk -F'\t' 'NR>1 {print $8}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)
    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done
echo "${category[@]}"
echo "${values1[@]}"
echo "${values2[@]}"
tsv_line=$(printf "%s\t" "${category[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" > ${direc_mhp}/stats_dtc/totallenght.tsv
tsv_line=$(printf "%s\t" "${values1[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_dtc/totallenght.tsv
tsv_line=$(printf "%s\t" "${values2[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_dtc/totallenght.tsv

# Scaffold - FROM QUAST
category=()
values1=()
values2=()
for i in "${complete[@]}"; do
    cat=$i
    val1=$(awk -F'\t' 'NR>1 {print $2}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)
    val2=$(awk -F'\t' 'NR>1 {print $2}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)
    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done
for i in "${uncomplete[@]}"; do
    cat=$i
    val1=$(awk -F'\t' 'NR>1 {print $2}' ${mhp_strains}${i}/Use/quast_draft/transposed_report.tsv)
    val2=$(awk -F'\t' 'NR>1 {print $2}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)
    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done
echo "${category[@]}"
echo "${values1[@]}"
echo "${values2[@]}"
tsv_line=$(printf "%s\t" "${category[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" > ${direc_mhp}/stats_dtc/scaffolds.tsv
tsv_line=$(printf "%s\t" "${values1[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_dtc/scaffolds.tsv
tsv_line=$(printf "%s\t" "${values2[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_dtc/scaffolds.tsv

# GC content - FROM QUAST
category=()
values1=()
values2=()
for i in "${complete[@]}"; do
    cat=$i
    val1=$(awk -F'\t' 'NR>1 {print $17}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)
    val2=$(awk -F'\t' 'NR>1 {print $17}' ${mhp_strains}${i}/Use/quast_complete/transposed_report.tsv)
    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done
for i in "${uncomplete[@]}"; do
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
echo "$tsv_line" > ${direc_mhp}/stats_dtc/gccontent.tsv
tsv_line=$(printf "%s\t" "${values1[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_dtc/gccontent.tsv
tsv_line=$(printf "%s\t" "${values2[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_dtc/gccontent.tsv

# Completeness - FROM BUSCO
category=()
values1=()
values2=()
for i in "${complete[@]}"; do
    cat=$i
    val1=$(jq '.results."Complete percentage"' ${mhp_strains}${i}/Use/busco_complete/short_summary.specific.mycoplasmatales_odb10.busco_complete.json)
    val2=$(jq '.results."Complete percentage"' ${mhp_strains}${i}/Use/busco_complete/short_summary.specific.mycoplasmatales_odb10.busco_complete.json)
    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done
for i in "${uncomplete[@]}"; do
    cat=$i
    val1=$(jq '.results."Complete percentage"' ${mhp_strains}${i}/Use/busco_draft/short_summary.specific.mycoplasmatales_odb10.busco_draft.json)
    val2=$(jq '.results."Complete percentage"' ${mhp_strains}${i}/Use/busco_complete/short_summary.specific.mycoplasmatales_odb10.busco_complete.json)
    category+=($cat)
    values1+=($val1)
    values2+=($val2)
done
echo "${category[@]}"
echo "${values1[@]}"
echo "${values2[@]}"
tsv_line=$(printf "%s\t" "${category[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" > ${direc_mhp}/stats_dtc/completenessbusco.tsv
tsv_line=$(printf "%s\t" "${values1[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_dtc/completenessbusco.tsv
tsv_line=$(printf "%s\t" "${values2[@]}")
tsv_line=${tsv_line%$'\t'}
echo "$tsv_line" >> ${direc_mhp}/stats_dtc/completenessbusco.tsv

# END
