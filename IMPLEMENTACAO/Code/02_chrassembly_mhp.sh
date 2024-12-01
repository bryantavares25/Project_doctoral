#!/bin/bash

conda init bash

# # # # #

# Organization USE

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

complete=()
for file in $(cat $mhp_list); do
    result=$(awk -v id="$file" '($5 == id && ($0 ~ /Complete/ || $0 ~ /Chromosome/)) {print $5}' $mhp_table)
    if [ -n "$result" ]; then
        found=true
    else
        found=false
    fi
    echo $file $found
    complete+=($file)
done
    if [ "$found" == true ]; then # COMPLETE
        conda activate busco
        cd ${mhp_strains}${file}/Use/
        busco -i ${mhp_strains}${file}/Use/G*/G*.fna -m genome -l mycoplasmatales_odb10 -o busco_complete
        cd ..
        conda deactivate

        conda activate quast
        quast ${mhp_strains}${file}/Use/G*/G*.fna -o ${mhp_strains}${file}/Use/quast_complete
        conda deactivate

        cd

    elif [ "$found" == false ]; then # DRAF
        echo "----------------------------------------- BUSCO DRAFT -----------------------------------------------"
        conda activate busco
        cd ${mhp_strains}${file}/Use/
        busco -i ${mhp_strains}${file}/Use/G*/G*.fna -m genome -l mycoplasmatales_odb10 -o busco_draft
        cd ..
        conda deactivate

        echo "----------------------------------------- QUAST DRAFT -----------------------------------------------"
        conda activate quast
        quast ${mhp_strains}${file}/Use/G*/G*.fna -o ${mhp_strains}${file}/Use/quast_draft
        conda deactivate

        ### Organization

        ### RAGTAG     
        
        # Scaffold
        echo "----------------------------------------- RAGTAG SCAFFOLD -----------------------------------------------"
        conda activate ragtag
        mkdir -p ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/
        mkdir -p ${mhp_strains}${file}/Use/ragtag/ragtag_merge/
        mkdir -p ${mhp_strains}${file}/Use/ragtag/ragtag_patch/
        select_sum=0
        select_strain=""
        for i in "${complete[@]}"; do
            ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out_${i}/ ${mhp_strains}${i}/Use/G*/G*.fna ${mhp_strains}${file}/Use/G*/G*.fna
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
        done
        echo "$select_strain" > ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/${select_strain}
        # Merge
        #mkdir -p ${mhp_strains}${file}/Use/ragtag/ragtag_merge/
        #echo "----------------------------------------- RAGTAG MERGE -----------------------------------------------"
        #ragtag.py merge ${mhp_strains}${file}/Use/G*/G*.fna ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out*/*agp -o ${mhp_strains}${file}/Use/ragtag/ragtag_merge/
        
        # Patch
        echo "----------------------------------------- RAGTAG PATCH -----------------------------------------------"
        ragtag.py patch ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out_${select_strain}/ragtag.scaffold.fasta ${mhp_strains}${select_strain}/Use/G*/G*.fna -o ${mhp_strains}${file}/Use/ragtag/ragtag_patch/
        conda deactivate

        echo "----------------------------------------- BUSCO COMPLETE -----------------------------------------------"
        conda activate busco
        cd ${mhp_strains}${file}/Use/
        busco -i ${mhp_strains}${file}/Use/ragtag/ragtag_patch/ragtag.patch.fasta -m genome -l mycoplasmatales_odb10 -o busco_complete
        cd ..
        conda deactivate

        echo "----------------------------------------- QUAST COMPLETE -----------------------------------------------"
        conda activate quast
        quast ${mhp_strains}${file}/Use/ragtag/ragtag_patch/ragtag.patch.fasta -o ${mhp_strains}${file}/Use/quast_complete
        conda deactivate

        cd 
    else
        echo "ERRO"
    fi
done