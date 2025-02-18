#!/bin/bash

# START

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef

# INPUT FILE

r=(OG0000011 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359)

# EXECUTION

# Read
coc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv

while IFS=$'\t' read -r c1 c2 c3 c4 c5 c6 c7 c8; do

    if [[ "$c1" == "MHP" ]]; then
        echo "MHP"
        la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/${c2}/Use" -type f -path "*/G*.1/cds_from_genomic.fna" 2>/dev/null)
        echo $la
    else
        echo "MFC"
        la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/${c2}/Use" -type f -path "*/G*.1/cds_from_genomic.fna" 2>/dev/null)
        echo $la
    fi
    
 
done < $coc

#$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/ATCC27716/Use/GCF_000367185.1/cds_from_genomic.fna



# END
