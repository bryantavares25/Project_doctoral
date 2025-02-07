#!/bin/bash

# START > > > OPERON ORGANIZATION

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef

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
    #ls $local$mhp && recip=$local$mhp || ls $local$mfc && recip=$local$mfc
    #echo $recip
    #rec=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv

    output="/home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c1}_{}"
    # Executa seqkit diretamente para extrair a sequência
    
    if [ "$c7" == "+" ]; then
        echo "+"
    else
        echo "-"
    fi 
    #seqkit subseq -r "$a:$b" "$fasta_ref" -o $output
    #seqkit subseq -r "$a:$b" "$fasta_ref" | seqkit seq --reverse --complement >> "$output"
done < $t

# Recovery sequence
# Construc GFF and Update
#
#END > > >
# Ms42	OG0000003	MHP7448_RS03870	MYF_RS01515	395941	402036	-	MYF_RS03220,MYF_RS01500,MYF_RS01505,MYF_RS01510,MYF_RS01515