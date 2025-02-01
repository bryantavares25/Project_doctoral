#!/bin/bash

# Folders
#dir=/home/lgef
dir=/home/bryan

direc_mfc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare
mfc_table=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

for file in $(cat $mfc_list); do
    # Folders
    mfc_gff_data=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/gff_data.tsv
    mfc_gff_strand=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/gff_strand.tsv
    mfc_genes_location_clean=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_location_clean.tsv
    mfc_genes_location_clean_strand=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_location_clean_strand.tsv
    mfc_genes_location_strand_complete=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_strand_complete.tsv
    mfc_genes_location_strand_final=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_strand_final.tsv
    mfc_genes_map=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_map.tsv
    mfc_genomic_gff=$(find "${direc_mfc}/strains/${file}/Use/" -type f -path "*/G*.1/g*.gff")
    mfc_genomic_gff_novo=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/genomic.gff

    mkdir -p $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/

    # Criar arquivos para estabelecer a strand correta

    mfc_genes_location_clean_org=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_location_clean_org.tsv

    awk 'BEGIN {OFS="\t"} {print $5, $1, $2, $3, $4}' $mfc_gff_data > $mfc_gff_strand
    awk 'BEGIN {OFS="\t"} {print two_before, $1, $4, $5, $6; two_before=one_before; one_before=$1}' $mfc_genes_location_clean > $mfc_genes_location_clean_org
    awk 'BEGIN {OFS="\t"} NR%3 == 0 {print $0}' $mfc_genes_location_clean_org > $mfc_genes_location_clean_strand
    
    # Colando arquivos   
    paste $mfc_gff_strand $mfc_genes_location_clean_strand > $mfc_genes_location_strand_complete
    # Calculando final strand
    awk 'BEGIN {OFS="\t"} {
        if ($8 == "+") {
            print $0, $3
        } else {
            if ($3 == "+") sign = "-" 
            else if ($3 == "-") sign = "+"
            print $0, sign
        }
    }' $mfc_genes_location_strand_complete > $mfc_genes_location_strand_final

    # Criando mapa
    awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $4, $5, $6, $7, $11, $9, $10'} $mfc_genes_location_strand_final > $mfc_genes_map

    # Substituição da localização
    awk 'BEGIN { OFS="\t" }
        NR==FNR {
            key = $2 FS $4 FS $5 FS $3
            map[key] = $7 FS $9 FS $10 FS $8
            next
        }
        {
            key = $1 FS $4 FS $5 FS $7
            if (key in map) {
                split(map[key], new_values, FS)
                $1 = new_values[1]
                $4 = new_values[2]
                $5 = new_values[3]
                $7 = new_values[4]
            }
            print
        }' $mfc_genes_map $mfc_genomic_gff > $mfc_genomic_gff_novo
done

# END > > > 
# GENOMES TO GENE_CLUSTERS
#A partir do genomic_novo_gff gerado, será possível prosseguir para as análises estruturais