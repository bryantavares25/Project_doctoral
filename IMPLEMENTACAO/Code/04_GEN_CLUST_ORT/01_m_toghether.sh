#!/bin/bash

# START > > > OPERON SELECTION

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef

# E X E C U T I O N

#dir=/home/bryan
OG=(OG0000003 OG0000011 OG0000013 OG0000055 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359 OG0000427 OG0000458 OG0000472 OG0000497 OG0000523 OG0000532 OG0000537 OG0000538 OG0000553 OG0000599 OG0000608)

#mesomycoplasma
mhp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/mhp_gene_co.tsv
mfc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/mfc_gene_co.tsv

#
cat $mhp $mfc > /home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv
