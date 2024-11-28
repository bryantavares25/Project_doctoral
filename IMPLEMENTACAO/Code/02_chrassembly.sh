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
        mkdir -p ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/
        complete=(J ES2 133A 131B 111A LH 154B 153B ES2L 116 Ue273 F72C 1257 NCTC10127 168 168L 7448 7422 232 KM014)
        select_sum=0
        select_strain=""
        for i in "${complete[@]}"; do
            #ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out_${i}/ ${mhp_strains}${i}/Use/G*/G*.fna ${mhp_strains}${file}/Use/G*/G*.fna
            echo $i
            b=(2 3 4)
            sum=0
            for c in "${b[@]}"; do
                array=($(awk -v id="$c" '{print $id}' ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out_${i}/ragtag.scaffold.confidence.txt))
                soma=0
                for valor in "${array[@]}"; do
                    soma=$(echo "$soma + $valor" | bc)
                done
                echo "Soma dos valores para $c: $soma"
                sum=$(echo "$sum + $soma" | bc)
            done
            if (($(echo "$sum > $select_sum" | bc -l))); then
                select_sum=$sum
                select_strain=$i
            fi
            echo $select_strain
            echo $select_sum
        done
        echo $select_strain
        echo $select_sum
        echo "Cepa com maior soma: $select_strain"
        echo "Soma: $select_sum"

        # Merge
        mkdir -p ${mhp_strains}${file}/Use/ragtag/ragtag_merge/
        ragtag.py merge ${mhp_strains}${file}/Use/G*/G*.fna ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out*/*agp -o ${mhp_strains}${file}/Use/ragtag/ragtag_merge/
        # Patch
        # Select major confidence

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