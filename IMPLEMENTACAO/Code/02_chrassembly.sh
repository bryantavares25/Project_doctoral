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
        for i in 
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out01 ${mhp_strains}J/Use/GCF_000008205.1/GCF_000008205.1_ASM820v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out02 ${mhp_strains}ES2/Use/GCF_004768725.1/GCF_004768725.1_ASM476872v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out03 ${mhp_strains}133A/Use/GCA_045006005.1/GCA_045006005.1_ASM4500600v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out04 ${mhp_strains}131B/Use/GCA_045006015.1/GCA_045006015.1_ASM4500601v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out05 ${mhp_strains}111A/Use/GCA_045006665.1/GCA_045006665.1_ASM4500666v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out06 ${mhp_strains}LH/Use/GCF_021383865.1/GCF_021383865.1_ASM2138386v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out07 ${mhp_strains}154B/Use/GCA_045005345.1/GCA_045005345.1_ASM4500534v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out08 ${mhp_strains}153B/Use/GCA_045005995.1/GCA_045005995.1_ASM4500599v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out09 ${mhp_strains}ES2L/Use/GCF_013402755.1/GCF_013402755.1_ASM1340275v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out10 ${mhp_strains}116/Use/GCF_040026155.1/GCF_040026155.1_ASM4002615v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out11 ${mhp_strains}Ue273/Use/GCF_039907915.1/GCF_039907915.1_ASM3990791v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out12 ${mhp_strains}F72C/Use/GCF_007923985.1/GCF_007923985.1_ASM792398v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out13 ${mhp_strains}1257/Use/GCF_040026965.1/GCF_040026965.1_ASM4002696v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out14 ${mhp_strains}NCTC10127/Use/GCF_900660565.1/GCF_900660565.1_51334_A01-3_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out15 ${mhp_strains}168/Use/GCF_000183185.1/GCF_000183185.1_ASM18318v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out16 ${mhp_strains}168L/Use/GCF_000400855.1/GCF_000400855.1_ASM40085v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out17 ${mhp_strains}7448/Use/GCF_000008225.1/GCF_000008225.1_ASM822v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out18 ${mhp_strains}7422/Use/GCF_000427215.1/GCF_000427215.1_ASM42721v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out19 ${mhp_strains}232/Use/GCF_000008405.1/GCF_000008405.1_ASM840v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
        ragtag.py scaffold -o ${mhp_strains}${file}/Use/ragtag/ragtag_scaffold/out20 ${mhp_strains}KM014/Use/GCF_002257505.1/GCF_002257505.1_ASM225750v1_genomic.fna ${mhp_strains}${file}/Use/G*/G*.fna
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

ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out01 ${mhp_strains}J/Use/GCF_000008205.1/GCF_000008205.1_ASM820v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out02 ${mhp_strains}ES2/Use/GCF_004768725.1/GCF_004768725.1_ASM476872v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out03 ${mhp_strains}133A/Use/GCA_045006005.1/GCA_045006005.1_ASM4500600v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out04 ${mhp_strains}131B/Use/GCA_045006015.1/GCA_045006015.1_ASM4500601v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out05 ${mhp_strains}111A/Use/GCA_045006665.1/GCA_045006665.1_ASM4500666v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out06 ${mhp_strains}LH/Use/GCF_021383865.1/GCF_021383865.1_ASM2138386v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out07 ${mhp_strains}154B/Use/GCA_045005345.1/GCA_045005345.1_ASM4500534v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out08 ${mhp_strains}153B/Use/GCA_045005995.1/GCA_045005995.1_ASM4500599v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out09 ${mhp_strains}ES2L/Use/GCF_013402755.1/GCF_013402755.1_ASM1340275v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out10 ${mhp_strains}116/Use/GCF_040026155.1/GCF_040026155.1_ASM4002615v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out11 ${mhp_strains}Ue273/Use/GCF_039907915.1/GCF_039907915.1_ASM3990791v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out12 ${mhp_strains}F72C/Use/GCF_007923985.1/GCF_007923985.1_ASM792398v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out13 ${mhp_strains}1257/Use/GCF_040026965.1/GCF_040026965.1_ASM4002696v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out14 ${mhp_strains}NCTC10127/Use/GCF_900660565.1/GCF_900660565.1_51334_A01-3_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out15 ${mhp_strains}168/Use/GCF_000183185.1/GCF_000183185.1_ASM18318v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out16 ${mhp_strains}168L/Use/GCF_000400855.1/GCF_000400855.1_ASM40085v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out17 ${mhp_strains}7448/Use/GCF_000008225.1/GCF_000008225.1_ASM822v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out18 ${mhp_strains}7422/Use/GCF_000427215.1/GCF_000427215.1_ASM42721v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out19 ${mhp_strains}232/Use/GCF_000008405.1/GCF_000008405.1_ASM840v1_genomic.fna
ragtag.py scaffold -o ${mhp_strains}${file}Use/ragtag/ragtag_scaffold/out20 ${mhp_strains}KM014/Use/GCF_002257505.1/GCF_002257505.1_ASM225750v1_genomic.fna