#!/bin/bash

# START

# ARCHIVE
#dir=/home/bryan
dir=/home/lgef

# INPUT FILE

r=(OG0000011 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359)

# EXECUTION

# Read
coc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv
while IFS=$'\t' read -r c1 c2 c3 c4 c5 c6 c7 c8; do

    if [[ "$c1" == "MHP" ]]; then
        la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/${c2}/Use/" -type f -path "*GC*.1/cds_from_genomic.fna") #2>/dev/null
        echo $la
        IFS=',' read -r -a l <<< "$c8"
        for g in ${l[@]}; do
<<<<<<< Updated upstream
            echo $g
            bioawk -c fastx -v g="$g" '{if ($comment ~ g) print g, $comment}' $la
=======
            bioawk -c fastx -v g="$g" '{if ($comment ~ g) print g, $comment, $seq}' $la
>>>>>>> Stashed changes
        done
    else
<<<<<<< Updated upstream
        echo "MFC" $c4 $c8
        la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/${c2}/Use" -type f -path "*/G*.1/cds_from_genomic.fna")

        IFS=',' read -r -a l <<< "$c8"
        for g in ${l[@]}; do
            echo $g
            bioawk -c fastx -v g="$g" '{if ($comment ~ g) print g, $comment}' $la
=======
        la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/${c2}/Use/" -type f -path "*GC*.1/cds_from_genomic.fna")
        echo $la
        IFS=',' read -r -a h <<< "$c8"
        for g in ${h[@]}; do
            bioawk -c fastx -v g="$g" '{if ($comment ~ g) print g, $comment, $seq}' $la
>>>>>>> Stashed changes
        done
    fi
done < $coc

# END
