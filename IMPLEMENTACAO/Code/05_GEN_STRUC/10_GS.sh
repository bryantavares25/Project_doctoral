#!/bin/bash

# START

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef

# INPUT FILE

r=(OG0000011 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359)

tmpfile=$(mktemp)
printf "%s\n" "${r[@]}" > "$tmpfile"

# EXECUTION

# Read
coc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv

while IFS=$'\t' read -r c1 c2 c3 c4 c5 c6 c7 c8; do

    if grep -Fxq $c4 $tmpfile; then
        if [[ "$c1" == "MHP" ]]; then
            echo "MHP $c4 $c8"
            la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/${c2}/Use" -type f -path "*/G*.1/cds_from_genomic.fna")
            IFS=',' read -r -a l <<< "$c8"
            for g in ${l[@]}; do
                bioawk -c fastx -v g="$g" '{if ($comment ~ g) print ">"g"\n"$seq}' $la >> $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c2}_${c4}.fasta
            done
        else
            echo "MFC" $c4 $c8
            la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/${c2}/Use" -type f -path "*/G*.1/cds_from_genomic.fna") 

            IFS=',' read -r -a l <<< "$c8"
            for g in ${l[@]}; do
                bioawk -c fastx -v g="$g" '{if ($comment ~ g) print ">"g"\n"$seq}' $la >> $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c2}_${c4}.fasta
            done
        fi
    else
        echo "No"
    fi
done < $coc

# Remove o arquivo temporário
rm -f "$tmpfile"

# END
