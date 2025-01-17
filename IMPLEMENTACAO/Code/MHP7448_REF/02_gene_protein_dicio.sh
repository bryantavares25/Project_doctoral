#!/bin/bash

# Arquivo FASTA de entrada
file="/home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/ATCC27716/Use/GCF_000367185.1/cds_from_genomic.fna"

dir=/home/lgef
#dir=/home/bryan

for i in si; do  ; done

# Processar o arquivo para criar o dicionário
awk -F '[][]' '/^>/{ 
    for (i=1; i<=NF; i++) { 
        if ($i ~ /^locus_tag=/) locus_tag=substr($i, 11) 
        if ($i ~ /^protein_id=/) protein_id=substr($i, 12) 
    } 
    if (locus_tag && protein_id) 
        print locus_tag, protein_id
}' $file > /home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Code/MHP7448_REF/Test.txt
