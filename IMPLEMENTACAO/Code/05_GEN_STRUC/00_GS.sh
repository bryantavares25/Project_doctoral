#!/bin/bash

# START > > > OPERON ORGANIZATION

# ARCHIVE
#dir=/home/bryan
dir=/home/lgef

# INPUT FILE

r=(OG0000011 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359)

t=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv

# EXECUTION

while IFS=$'\t' read -r c1 c2 c3 c4 c5 c6 c7 c8; do
    #for item in "${r[@]}"; do
        #if [[ "$linha" == *"$item"* ]]; then
    echo " - Iniciando linha"
    if [[ " ${r[@]} " =~ " $c2 " ]]; then
        echo "SoS"
        a=$((c5 - 250))
        b=$((c6 + 250))
        
        local=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/
        mhp=M_hyopneumoniae/mult_align/seqs_to_align/$c1.fasta
        mfc=M_flocculare/mult_align/seqs_to_align/$c1.fasta

        ls $local$mhp 2>/dev/null && recip=$local$mhp || ls $local$mfc 2>/dev/null && recip=$local$mfc
        
        output_fasta="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c1}_${c2}_${c3}_${c4}.fasta"
        output_gff="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c1}_${c2}_${c3}_${c4}.fasta"

        if [ "$c7" == "+" ]; then
            # Recovery sequence
            seqkit subseq -r "$a:$b" "$recip" -o $output_fasta
        
            # Construc GFF and Update
            #c8="MHL_RS03735,MHL_RS02240,MHL_RS02245,MHL_RS02250,MHL_RS02255"
            IFS=',' read -r -a l <<< "$c8"
            for g in ${l[@]}; do
                grep -E "RefSeq.*$g" $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic.gff >> $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic_target.gff
            done
            
            tac $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic_target.gff | \
            awk '{temp=$4; $4=$5; $5=temp} 1' | \
            awk 'NR==1 {delta = $4 - 250; $4 = 250; $5 -= delta} NR>1 {$4 -= delta; $5 -= delta} {print}' > $output_gff
        else
            # Recovery sequence
            seqkit subseq -r "$a:$b" "$recip" | seqkit seq --reverse --complement > $output_fasta
            
            # Construc GFF and Update
            IFS=',' read -r -a l <<< "$c8"
            for g in ${l[@]}; do
                grep -E "RefSeq.*$g" $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic.gff >> $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic_target.gff
            done

            tac $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic_target.gff | \
            awk '{temp=$4; $4=$5; $5=temp} 1' | \
            awk 'NR==1 {delta = $4 + 250; $4 = 250; $5 = -$5 +delta} NR>1 {$4 = -$4 + delta; $5 = -$5 + delta} {print}' > $output_gff
        fi 
    else
        echo "NoN"
    fi
    echo " - Finalizando linha"
done < $t

#seqid  source  type  start  end  score  strand  phase  attributes

# Construc GFF and Update
#
#END > > >
# Ms42	OG0000003	MHP7448_RS03870	MYF_RS01515	395941	402036	-	MYF_RS03220,MYF_RS01500,MYF_RS01505,MYF_RS01510,MYF_RS01515
# Ms42	OG0000003	MHP7448_RS03870	MYF_RS01515	402040	502036	-	MYF_RS03220,MYF_RS01500,MYF_RS01505,MYF_RS01510,MYF_RS01515
# Ms42	OG0000003	MHP7448_RS03870	MYF_RS01515	502040	602036	-	MYF_RS03220,MYF_RS01500,MYF_RS01505,MYF_RS01510,MYF_RS01515
