#!/bin/bash

# START > > > OPERON SELECTION

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
ort=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder

# INPUT FILE
OG=(OG0000003 OG0000011 OG0000013 OG0000055 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359 OG0000427 OG0000458 OG0000472 OG0000497 OG0000523 OG0000532 OG0000537 OG0000538 OG0000553 OG0000599 OG0000608)
mhp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/output_proteins/gene_id/Orthologues/MHP_7448_genes.tsv
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_after=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/mhp_gene_co.tsv
mhp_after_operon=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv

# EXECUTION
while read -r line; do

    mhp_coc_clean=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$line/genomic_gene_coc_clean.bed

    # Pegar cada linha e descobrir operon
    while IFS=$'\t' read -r col1 col2 col3 col4; do
        awk -v line="$line" -v col1="$col1" -v col2="$col2" -v col3="$col3" -v col4="$col4" -F'\t' '($1 ~ line) && ($0 ~ col4) {print col2, col1, col3, col4, $2, $3, $5, $4}' OFS='\t' $mhp_coc_clean >> $mhp_after_operon
    done < $mhp_after

done < $mhp_list

# E N D > > > TO OPERON ORGANIZATION