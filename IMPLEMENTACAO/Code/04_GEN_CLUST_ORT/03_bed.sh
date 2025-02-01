#!/bin/bash

# START > > > OPERON ORGANIZATION

# ARCHIVE
#dir=/home/bryan
dir=/home/lgef
org=$dir/Documents/Projects/Project_REGENERA/Project_VANESSA/Bioluminescentes

# INPUT FILE

input_faa=$(find "${org}/Genome_02v/Genomes/${line}/12_ref_ann/prokka/" -type f | grep -E ".*\.faa")

targ_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/03_PROKKA_targets.txt
targ_faa=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/07_PROKKA_faa.fasta

# EXECUTION

# Recovery protein sequence
seqtk subseq "$input_faa" "$targ_bed" > "$targ_faa"

#END > > >

# Recovery nuc of operon region
#trun_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/$line/02_PROKKA_transcriptunit.bed
#awk 'BEGIN {OFS = "\t"} {print $0}' "$trun_bed"

# awk 'BEGIN {OFS = "\t"} NR > 1725 {print prev} {prev=$2}' 02_PROKKA_transcriptunit.bed

#seqtk subseq 