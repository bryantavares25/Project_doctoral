#!/bin/bash

# START > > > OPERON SELECTION

# ARCHIVE
#dir=/home/bryan
dir=/home/lgef
mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
ort=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder

# E X E C U T I O N

#dir=/home/bryan
OG=(OG0000003 OG0000011 OG0000013 OG0000055 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359 OG0000427 OG0000458 OG0000472 OG0000497 OG0000523 OG0000532 OG0000537 OG0000538 OG0000553 OG0000599 OG0000608)

#mfc
mfc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/output_proteins/gene_id/Orthologues/MHP_7448_genes.tsv
mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_after=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co.tsv

#rm $mfc_after

while read -r line; do
    mfc_cb=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$line/genomic_gene_coc.bed
    mfc_cbc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$line/genomic_gene_coc_clean.bed
    awk -F'\t' 'BEGIN {OFS="\t"} {gsub(/gene-/, "", $4); print}' $mfc_cb > $mfc_cbc
    for og in "${OG[@]}"; do
        awk -v line="$line" -v og="$og" -F'\t' 'BEGIN {OFS = "\t"}
        $2 ~ ("MFC_" line "_genes") && $1 ~ (og) {
        n = split ($NF, ids, ", ")
        for (i = 1; i <= n; i++) 
            print $1, line, $3, ids[i]          
        }' $mfc >> $mfc_after
    done
done < $mfc_list

# E N D