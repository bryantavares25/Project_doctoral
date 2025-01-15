#!/bin/bash

dir=/home/lgef
#dir=/home/bryan

#/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/Orthofinder
input_folder=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/

direc_mfc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare
mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
for file in $(cat $mfc_list); do
    cd ${direc_mfc}/strains/${file}/Use/G*.1 # OK
    cp protein.faa ${file}_proteins_mfc.fasta
    #rm ${file}_proteins.fasta
    cd
    mv ${direc_mfc}/strains/${file}/Use/G*.1/${file}_proteins_mfc.fasta $input_folder
done

direc_mhp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
for file in $(cat $mhp_list); do
    cd ${direc_mhp}/strains/${file}/Use/G*.1 # OK
    cp protein.faa ${file}_proteins_mhp.fasta
    #rm ${file}_proteins.fasta
    cd
    mv ${direc_mhp}/strains/${file}/Use/G*.1/${file}_proteins_mhp.fasta $input_folder
done

# # # END > > > RUN ORTHOFINDER

#