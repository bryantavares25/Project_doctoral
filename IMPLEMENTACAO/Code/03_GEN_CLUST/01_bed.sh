#!/bin/bash

# START > > > OPERON VIEWER

# ARCHIVE
dir=/home/regenera
org=$dir/Documents/Projects/Project_REGENERA/Project_VANESSA/Bioluminescentes

# INPUT FILE
read -r line < /home/regenera/Documents/Github/Project_regenera/VAN_projects/strain.txt
#line=REG_001554_SEQ_240819201486
echo $line 

input_gff=$(find "${org}/Genome_02v/Genomes/${line}/12_ref_ann/prokka/" -type f | grep -E ".*\.gff")

pipe_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/${line}/00_PROKKA.bed
pipe_sor=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/${line}/01_PROKKA_sort.bed
trun_bed=$dir/Documents/Github/Project_regenera/VAN_projects/Genomes/${line}/02_PROKKA_transcriptunit.bed

# EXECUTION 

# .gff to .bed [Ajuste de formatação]
awk 'BEGIN { OFS = "\t" } $3 == "CDS" || $3 == "tRNA" { 
        split($9, a, ";")
        split(a[1], b, "=")
        print $1, $4-1, $5, b[2], 0, $7
    }' "$input_gff" > "$pipe_bed"
#$1 Sequence-region | $4

# Sort data [ordenação dos dados > Cromossomo:Inicio] 
sort -k1,1 -k2,2n "$pipe_bed" > "$pipe_sor"

awk 'BEGIN { OFS = "\t" }
{
    if (NR == 1 || $6 == strand && $1 == chr) {
        if (NR == 1) {
            chr = $1; start = $2; end = $3; strand = $6; genes = $4
        } else {
            end = $3; genes = genes "," $4
        }
    } else {
        print chr, start, end, genes, strand
        chr = $1; start = $2; end = $3; strand = $6; genes = $4
    }
}
END {
    print chr, start, end, genes, strand
}' "$pipe_sor" > "$trun_bed"

# E N D > > > TO OPERON SELECTION