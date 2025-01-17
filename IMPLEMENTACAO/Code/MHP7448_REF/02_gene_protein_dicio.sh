#!/bin/bash

dir=/home/lgef
#dir=/home/bryan

mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
for i in $(cat $mfc_list); do
    reference=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/${i}/Use/" -type f -path "*/G*.1/cds_from_genomic.fna")
    dicionary=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/dic_protein_gene/M_flocculare/${i}_dic.txt
    # Processar o arquivo para criar o dicionário
    awk -F '[][]' '/^>/{ 
        for (i=1; i<=NF; i++) { 
            if ($i ~ /^locus_tag=/) locus_tag=substr($i, 11) 
            if ($i ~ /^protein_id=/) protein_id=substr($i, 12) 
        } 
        if (locus_tag && protein_id) 
            print locus_tag, protein_id
    }' $reference > $dicionary
done

#!/bin/bash

dir=/home/lgef
#dir=/home/bryan

mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
for i in $(cat $mhp_list); do
    reference=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/${i}/Use/" -type f -path "*/G*.1/cds_from_genomic.fna")
    dicionary=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/orthofinder/input_proteins/dic_protein_gene/M_hyopneumoniae/${i}_dic.txt
    # Processar o arquivo para criar o dicionário
    awk -F '[][]' '/^>/{ 
        for (i=1; i<=NF; i++) { 
            if ($i ~ /^locus_tag=/) locus_tag=substr($i, 11) 
            if ($i ~ /^protein_id=/) protein_id=substr($i, 12) 
        } 
        if (locus_tag && protein_id) 
            print locus_tag, protein_id
    }' $reference > $dicionary
done