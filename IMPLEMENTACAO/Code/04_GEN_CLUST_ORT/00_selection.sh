#!/bin/bash

# START > > > OPERON SELECTION

OG=(OG0000003 OG0000011 OG0000013 OG0000055 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359 OG0000427 OG0000458 OG0000472 OG0000497 OG0000523 OG0000532 OG0000537 OG0000538 OG0000553 OG0000599 OG0000608)

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef

mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt

ort=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder

IMPLEMENTACAO/Gene_clusters/orthofinder/output_proteins/gene_id/Orthologues/MHP_7448_genes.tsv

#gene_id > Orthologues

# Uma árvore 
# Strain | OG | GENEID >>> pega o ID do gene >>> /home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/ATCC27716/genomic_gene_coc.bed

# E X E C U T I O N

for line in $(cat $mfc_list); do
    echo "MHP_${line}_genes"

    for gene in ${OG[@]}; do

        echo $gene

    done

done

# E N D
