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
    echo  echo $((c5 - 1))

    #rec=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv

done < $t
# Recovery sequence

# Construc GFF and Update

#

#END > > >

# Ms42	OG0000003	MHP7448_RS03870	MYF_RS01515	395941	402036	-	MYF_RS03220,MYF_RS01500,MYF_RS01505,MYF_RS01510,MYF_RS01515