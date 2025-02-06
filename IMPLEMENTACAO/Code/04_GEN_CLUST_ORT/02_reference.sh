#!/bin/bash

# START > > > OPERON ORGANIZATION

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef

# INPUT FILE

reference_table=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/reference_table.tsv
font=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/7448/genomic_gene_coc_clean.bed
output=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv

# EXECUTION

while IFS=$'\t' read -r c1 c2; do
    #while IFS=$'\t' read -r col1 col2 col3 col4 col5; do
    awk -v c1="$c1" -v c2="$c2" -F'\t' '($4 ~ c1) {print "7448", c2, c1, c1, $2, $3, $5, $4}' OFS='\t' $font >> $output
    #>> $mhp_after_operon
    #done < $font -v col1="$col1" -v col2="$col2" -v col3="$col3" -v col4="$col4" -v col5="$col5"
done < $reference_table



#END > > >

#KM014	OG0000608	MHP7448_RS03865	CIB43_RS02690	633855	636402	+	CIB43_RS02690,CIB43_RS02695,CIB43_RS02700,CIB43_RS02705,CIB43_RS02710

