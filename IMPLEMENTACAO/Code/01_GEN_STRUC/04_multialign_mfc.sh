#!/bin/bash

conda init bash

# # # #

pcH=/home/bryan/
pcL=/home/lgef/
pcR=/home/regenera/
direc_mfc=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare
mfc_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/
mfc_table=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

complete=()
uncomplete=()
genomes=()

mkdir -p ${direc_mfc}/mult_align/seqs_to_align/

for file in $(cat $mfc_list); do
    gi=$(awk -v id="$file" '($5 == id && ($0 ~ /Complete/ || $0 ~ /Chromosome/)) {print $5}' $mfc_table)
    result=$(awk -v id="$file" '($5 == id && ($0 ~ /Complete/ || $0 ~ /Chromosome/)) {print $5}' $mfc_table)
    genomes+=($direc_mfc/mult_align/seqs_to_align/$file.fasta)
    if [ -n "$result" ]; then # complete
        found=true
    else # uncomplete
        found=false
    fi
    
    echo $file $found

    if [ "$found" == true ]; then # COMPLETE
        grep -v "^>" ${mfc_strains}${file}/Use/G*.1/G*.fna | tr -d '\n' | sed "1 i >ID${file}" > ${direc_mfc}/mult_align/seqs_to_align/${file}.fasta
    elif [ "$found" == false ]; then # UNCOMPLETE
        grep -v "^>" ${mfc_strains}${file}/Use/ragtag/ragtag_patch/ragtag.patch.fasta | tr -d '\n' | sed "1 i >ID${file}" > ${direc_mfc}/mult_align/seqs_to_align/${file}.fasta
    else
        echo "ERRO"
    fi
done

conda activate sibelia
cd ${direc_mfc}/mult_align/
Sibelia -s loose "${genomes[@]}" --sequencesfile
cd 
conda deactivate

conda activate sibeliaz
cd ${direc_mfc}/mult_align/
sibeliaz "${genomes[@]}"
maf2synteny ${direc_mfc}/mult_aling/sibeliaz_out/alignment.maf
cd
conda deactivate

conda activate progressivemauve
cd ${direc_mfc}/mult_aling/
progressiveMauve "${genomes[@]}" --output=pm_alignment.xmfa
cd
conda deactivate