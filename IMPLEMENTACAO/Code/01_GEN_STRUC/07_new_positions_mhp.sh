#!/bin/bash

# Folders
#dir=/home/lgef
dir=/home/bryan

direc_mhp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae
mhp_table=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt

for file in $(cat $mhp_list); do
    # Folders
    mhp_gff_data=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/gff_data.tsv
    mhp_gff_strand=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/gff_strand.tsv
    mhp_genes_location_clean=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_location_clean.tsv
    mhp_genes_location_clean_strand=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_location_clean_strand.tsv
    mhp_genes_location_strand_complete=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_strand_complete.tsv
    mhp_genes_location_strand_final=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_strand_final.tsv
    mhp_genes_map=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_map.tsv
    mhp_genomic_gff=$(find "${direc_mhp}/strains/${file}/Use/" -type f -path "*/G*.1/g*.gff")
    mhp_genomic_gff_novo=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/genomic.gff

    mkdir -p $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/

    # Criar arquivos para estabelecer a strand correta
    
    mhp_genes_location_clean_org=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_location_clean_org.tsv

    awk 'BEGIN {OFS="\t"} {print $5, $1, $2, $3, $4}' $mhp_gff_data > $mhp_gff_strand
    awk 'BEGIN {OFS="\t"} {print two_before, $1, $4, $5, $6; two_before=one_before; one_before=$1}' $mhp_genes_location_clean > $mhp_genes_location_clean_org
    awk 'BEGIN {OFS="\t"} NR%3 == 0 {print $0}' $mhp_genes_location_clean > $mhp_genes_location_clean_strand
    
    # Colando arquivos   
    paste $mhp_gff_strand $mhp_genes_location_clean_strand > $mhp_genes_location_strand_complete
    # Calculando final strand
    awk 'BEGIN {OFS="\t"} {
        if ($8 == "+") {
            print $0, $3
        } else {
            if ($3 == "+") sign = "-" 
            else if ($3 == "-") sign = "+"
            print $0, sign
        }
    }' $mhp_genes_location_strand_complete > $mhp_genes_location_strand_final

    # Criando mapa
    awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $4, $5, $6, $7, $11, $9, $10'} $mhp_genes_location_strand_final > $mhp_genes_map

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
        }' $mhp_genes_map $mhp_genomic_gff > $mhp_genomic_gff_novo
done

# END > > > 
# GENOMES TO GENE_CLUSTERS
#A partir do genomic_novo_gff gerado, será possível prosseguir para as análises estruturais