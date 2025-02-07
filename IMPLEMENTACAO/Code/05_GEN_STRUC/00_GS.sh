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
    a=$((c5 - 250))
    b=$((c6 + 250))
    #echo $b

    local=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/
    mhp=M_hyopneumoniae/mult_align/seqs_to_align/$c1.fasta
    mfc=M_flocculare/mult_align/seqs_to_align/$c1.fasta

    ls $local$mhp 2>/dev/null && recip=$local$mhp || ls $local$mfc 2>/dev/null && recip=$local$mfc
    
    output="/home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c1}_${c2}_${c3}_${c4}.fasta"

    if [ "$c7" == "+" ]; then
        echo "+"
        # Recovery sequence
        seqkit subseq -r "$a:$b" "$recip" -o $output
        # Construc GFF and Update
    else
        echo "-"
        # Recovery sequence
        seqkit subseq -r "$a:$b" "$recip" | seqkit seq --reverse --complement > $output
        # Construc GFF and Update
    fi 
done < $t


#seqid  source  type  start  end  score  strand  phase  attributes

# Construc GFF and Update
#
#END > > >
# Ms42	OG0000003	MHP7448_RS03870	MYF_RS01515	395941	402036	-	MYF_RS03220,MYF_RS01500,MYF_RS01505,MYF_RS01510,MYF_RS01515
# Ms42	OG0000003	MHP7448_RS03870	MYF_RS01515	402040	502036	-	MYF_RS03220,MYF_RS01500,MYF_RS01505,MYF_RS01510,MYF_RS01515
# Ms42	OG0000003	MHP7448_RS03870	MYF_RS01515	502040	602036	-	MYF_RS03220,MYF_RS01500,MYF_RS01505,MYF_RS01510,MYF_RS01515

grep -F -f /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/ids.txt /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/genomic.gff > /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/01_genomic.gff
grep -E 'RefSeq.*MFC_RS00295' /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/genomic.gff >> /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/01_genomic.gff
tac /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/01_genomic.gff | awk '{temp=$4; $4=$5; $5=temp} 1' | awk 'NR==1 {delta = $4 + 250; $4 = 250; $5 = -$5 +delta} NR>1 {$4 -= delta; $5 -= delta} {print}' > /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/02_genomic.gff

tac /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/01_genomic.gff | \
awk '{temp=$4; $4=$5; $5=temp} 1' | \
awk 'NR==1 {delta = $4 - 250; $4 = 250; $5 -= delta} NR>1 {$4 -= delta; $5 -= delta} {print}' | \
tac > /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/02_genomic.gff
