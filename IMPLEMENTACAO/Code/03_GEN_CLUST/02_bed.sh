#!/bin/bash

# START > > > OPERON SELECTION

# ARCHIVE
dir=/home/regenera
org=$dir/Documents/Projects/Project_REGENERA/Project_VANESSA/Bioluminescentes

# INPUT FILE
read -r line < /home/regenera/Documents/Github/Project_regenera/VAN_projects/strain.txt
#line=REG_001554_SEQ_240819201486
echo $line

input_tsv=$(find "${org}/Genome_02v/Genomes/${line}/12_ref_ann/prokka/" -type f | grep -E "4.*\.tsv")

trun_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/02_PROKKA_transcriptunit.bed
targ_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/03_PROKKA_targets.txt
tufo_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/04_PROKKA_identify.bed
oper_ids=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/05_PROKKA_operonids.tsv
oper_nam=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/06_PROKKA_operonnames.tsv

# EXECUTION

# Found lux genes
awk '$2 == "CDS" && $4 ~ /luxA/ || $2 == "CDS" && $4 ~ /luxB/ {print $1}' "$input_tsv" > "$targ_bed"

# Found line with target
grep -Ff "$targ_bed" "$trun_bed" > "$tufo_bed"

#
awk 'BEGIN {OFS = "\t"} {print $4}' "$tufo_bed" > "$oper_ids"

# 
awk 'NR==FNR {map[$1] = $4; next} {
    n = split($1, ids, ",")
    for (i = 1; i <= n; i++) {
        if (ids[i] in map) {
            ids[i] = map[ids[i]]
        }
    }
    $1 = ids[1]
    for (j = 2; j <= n; j++) {
        $1 = $1 "," ids[j]
    }
    print
}' "$input_tsv" "$oper_ids" > "$oper_nam"

# E N D > > > TO OPERON ORGANIZATION