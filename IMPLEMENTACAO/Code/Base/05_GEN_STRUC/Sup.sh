#!/bin/bash

# START

# DIRECTORY SETUP
dir="/home/lgef"

# INPUT FILE
r=(OG0000011 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359)

# FILE WITH DATA
coc="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv"

# EXECUTION

# Read `coc` line by line
while IFS=$'\t' read -r c1 c2 c3 c4 c5 c6 c7 c8; do

    if [[ "$c1" == "MHP" ]]; then
        la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/${c2}/Use/" -type f -path "*GC*.1/cds_from_genomic.fna")
    else
        la=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/${c2}/Use/" -type f -path "*GC*.1/cds_from_genomic.fna")
    fi

    # Se o arquivo foi encontrado, continuar
    if [[ -n "$la" ]]; then
        echo "Arquivo encontrado: $la"
        
        # Separar os genes da coluna `c8`
        IFS=',' read -r -a genes <<< "$c8"
        echo $genes
        for g in "${genes[@]}"; do
            bioawk -c fastx -v g="$g" '{if ($name ~ g) print ">"$name"\n"$seq}' "$la"
        done
    else
        echo "Arquivo não encontrado para ${c2}"
    fi

done < "$coc"

# END
