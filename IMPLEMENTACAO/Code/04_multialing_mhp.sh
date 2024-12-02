#!/bin/bash

conda init bash

# # # #

pcH=/home/bryan/
pcL=/home/lgef/
pcR=/home/regenera/
direc_mhp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/
direc_mfc=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/
mhp_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/
mfc_strains=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/
mhp_table=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt
mfc_table=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

complete=()
uncomplete=()
genomes=()
for file in $(cat $mhp_list); do
    gi=$(awk -v id="$file" '($5 == id && ($0 ~ /Complete/ || $0 ~ /Chromosome/)) {print $5}' $mhp_table)
    result=$(awk -v id="$file" '($5 == id && ($0 ~ /Complete/ || $0 ~ /Chromosome/)) {print $5}' $mhp_table)
    genomes+=($mhp_strains$file.fasta)
    if [ -n "$result" ]; then # complete
        found=true
    else # uncomplete
        found=false
    fi
    
    echo
    echo $file $found
    echo

    mkdir ${direc_mhp}mult_aling/seqs_to_aling/

    if [ "$found" == true ]; then # COMPLETE
            grep -v "^>" ${mhp_strains}${file}/Use/G*.1/G*.fna | tr -d '\n' | sed '1 i >"${file}"' > ${mhp_strains}${file}/Use/G*.1/${file}_combined.fasta
            mv mkdir ${direc_mhp}mult_aling/seqs_to_aling/
    
    elif [ "$found" == false ]; then # UNCOMPLETE
            grep -v "^>" ${mhp_strains}${file}/Use/ragtag/ragtag_patch/ragtag.patch.fasta | tr -d '\n' | sed '1 i >"${file}"' > ${mhp_strains}${file}/Use/ragtag/ragtag_patch/${file}_combined.fasta
            mv mkdir ${direc_mhp}mult_aling/seqs_to_aling/

done

conda activate sibeliaz

sibeliaz "${genomes[@]}" #sibeliaz genome1.fa genome2.fa 

conda deactivate

#echo "${complete[@]}"
#echo "${uncomplete[@]}"


