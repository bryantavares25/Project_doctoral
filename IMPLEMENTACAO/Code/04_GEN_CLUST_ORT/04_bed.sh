#!/bin/bash

# START > > > OPERON ORGANIZATION

dir=/home/regenera
org=$dir/Documents/Projects/Project_REGENERA/Project_VANESSA/Bioluminescentes

read -r line < /home/regenera/Documents/Github/Project_regenera/VAN_projects/strain.txt
#line=REG_001554_SEQ_240819201486
echo $line

pipe_sor=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/01_PROKKA_sort.bed
tufo_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/04_PROKKA_identify.bed

input_fasta=$(find "${org}/Genome_02v/Genomes/${line}/10_ref_ass/" -type f | grep -E ".*\patch.fasta")

# EXECUTION

wc -l $tufo_bed > /home/regenera/Documents/Github/Project_regenera/VAN_projects/Genomes/REG_001554_SEQ_240819201486/08_PROKKA_lines
y=$(cut -c1 /home/regenera/Documents/Github/Project_regenera/VAN_projects/Genomes/REG_001554_SEQ_240819201486/08_PROKKA_lines)

for i in $(seq 1 "$y"); do
    sr=$(awk -v lin="$i" 'NR == lin {print $1}' "$tufo_bed")
    cds_ini=$(awk -v lin="$i" ' NR == lin {split($4, a, ","); print a[1]}' "$tufo_bed")
    loc_ini=$(awk -v var="$cds_ini" '$0 ~ var {print prev} {prev=$2}' "$pipe_sor")
    cds_fin=$(awk -v lin="$i" 'NR == lin {split($4, a, ","); print a[length(a)]}' "$tufo_bed")
    loc_fin=$(awk -v var="$cds_fin" '$0 ~ var {getline; print $3}' "$pipe_sor")

    adja_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/08_PROKKA_adjacent_$i.txt

    h=($loc_ini $loc_fin)
    h_sorted=($(printf "%s\n" "${h[@]}" | sort -n))
    echo "$sr ${h_sorted[@]}" > "$adja_bed" 

    targ_fas=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/08_PROKKA_fasta_$i.fasta

    seqtk subseq "$input_fasta" "$adja_bed" > "$targ_fas"
done