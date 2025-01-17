#!/bin/bash

dir=/home/lgef
#dir=/home/bryan

mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
for i in $(cat $mfc_list); do
    input_fasta=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/proteins_id/MFC_${i}_proteins.fasta
    id_map=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/dic_protein_gene/M_flocculare/${i}_dic.txt
    output_fasta=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/genes_id/MFC_${i}_genes.fasta
    
    awk '
        BEGIN {
            while ((getline < "'"$id_map"'") > 0) {
                map[$2] = $1
            }
            close("'"$id_map"'")
        }
        /^>/ {
            split($1, id, ">")
            if (id[2] in map) {
                print ">" map[id[2]]
            } else {
                print $0
            }
            next
        }
        {
            print $0
        }' $input_fasta > $output_fasta
done

dir=/home/lgef
#dir=/home/bryan

mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
for i in $(cat $mhp_list); do
    input_fasta=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/proteins_id/MHP_${i}_proteins.fasta
    id_map=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/dic_protein_gene/M_hyopneumoniae/${i}_dic.txt
    output_fasta=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/genes_id/MHP_${i}_genes.fasta
    
    awk '
        BEGIN {
            while ((getline < "'"$id_map"'") > 0) {
                map[$2] = $1
            }
            close("'"$id_map"'")
        }
        /^>/ {
            split($1, id, ">")
            if (id[2] in map) {
                print ">" map[id[2]]
            } else {
                print $0
            }
            next
        }
        {
            print $0
        }' $input_fasta > $output_fasta
done
