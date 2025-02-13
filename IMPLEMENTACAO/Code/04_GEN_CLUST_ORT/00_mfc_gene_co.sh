#!/bin/bash

# START > > > OPERON SELECTION

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef
mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
ort=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder

# E X E C U T I O N

#dir=/home/bryan
OG=(OG0000003 OG0000011 OG0000013 OG0000055 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359 OG0000427 OG0000458 OG0000472 OG0000497 OG0000523 OG0000532 OG0000537 OG0000538 OG0000553 OG0000599 OG0000608)

#mfc
mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_after=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/mfc_gene_co.tsv

#rm $mfc_after

while read -r line; do
    mfc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/output_proteins/gene_id/Orthologues/MFC_${line}_genes.tsv # QUERO REMOVER ESSE CRITÈRIO
    
    
    mfc_cb=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$line/genomic_gene_coc.bed
    mfc_cbc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$line/genomic_gene_coc_clean.bed
    awk -F'\t' 'BEGIN {OFS="\t"} {gsub(/gene-/, "", $4); print}' $mfc_cb > $mfc_cbc
    for og in "${OG[@]}"; do

        # PEGAR ID DO GENE
        awk -v row_id="OG0000141" -v col_name="MFC_Ms42_genes" '
        BEGIN {
            FS = OFS = "\t"
        }
        NR == 1 {
            for (i=1; i<=NF; i++) col_index[$i] = i
            next
        }
        $1 == row_id {
            print $col_index[col_name]
        }' /home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/output_proteins/gene_id/Orthogroups/Orthogroups.tsv
        #
            # Fazer o split é importante
            #MFC_RS00010, MFC_RS00365, MFC_RS00390, MFC_RS01410, MFC_RS01420, MFC_RS02935
        #

        # FOR CADA 1 EM SPLIT: DO | RECUPERAR OPERON |

            awk -v line="$line" -v og="$og" -F'\t' 'BEGIN {OFS = "\t"}
            $2 ~ ("MFC_" line "_genes") && $1 ~ (og) {
            n = split ($NF, ids, ", ")
            for (i = 1; i <= n; i++) 
                print $1, line, $3, ids[i]          
            }' $mfc >> $mfc_after

    done
done < $mfc_list

# E N D