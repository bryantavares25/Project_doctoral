#!/bin/bash

# START > > > OPERON SELECTION

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
ort=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder

# E X E C U T I O N

#dir=/home/bryan
OG=(OG0000003 OG0000011 OG0000013 OG0000055 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359 OG0000427 OG0000458 OG0000472 OG0000497 OG0000523 OG0000532 OG0000537 OG0000538 OG0000553 OG0000599 OG0000608)

#mfc
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_after=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/mhp_gene_co.tsv

#rm $mfc_after

while read -r line; do
    mhp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/output_proteins/gene_id/Orthologues/MHP_${line}_genes.tsv

    mhp_cb=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$line/genomic_gene_coc.bed
    mhp_cbc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$line/genomic_gene_coc_clean.bed
    
    awk -F'\t' 'BEGIN {OFS="\t"} {gsub(/gene-/, "", $4); print}' $mhp_cb > $mhp_cbc
    
    for og in "${OG[@]}"; do
        
        # PEGAR ID DO GENE
        a=$(awk -v row_id="${og}" -v col_names="MHP_${line}_genes" '
        BEGIN {
            FS = OFS = "\t"
        }
        NR == 1 {
            for (i=1; i<=NF; i++) col_index[$i] = i
            next
        }
        $1 == row_id {
            split($col_index[col_name], values, ", ")
            for (j in values) print values[j]
        }' $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/output_proteins/gene_id/Orthogroups/Orthogroups.tsv)
        
        # Dados splitados
        for i in ${a[@]}; do
            # FOR CADA 1 EM SPLIT: DO | RECUPERAR OPERON |
            awk -v i="$i" -v og="$og" -v line="$line" -F'\t' 'BEGIN {OFS = "\t"}
            $0 ~ i {
                print line, i, og, $5, $2, $3, $4          
            }' $mhp_cbc >> $mhp_after
        done
    done
done < $mhp_list

# E N D