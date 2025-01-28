#!/bin/bash

# START > > > OPERON VIEWER

# ARCHIVE
#dir=/home/bryan
dir=/home/lgef
#org=$dir/Documents/Projects/Project_REGENERA/Project_VANESSA/Bioluminescentes

# INPUT FILE

# cat ?
#read -r line < $dir/Documents/Github/Project_regenera/VAN_projects/strain.txt
#line=REG_001554_SEQ_240819201486
#echo $line
#line=11

for line in $(cat $mhp_list); do
    input_gff=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/${line}" -type f | grep -E ".*\.gff")

    pipe_bed=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/${line}/genomic.bed
    pipe_sor=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/${line}/genomic_sort.bed
    trun_bed=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/${line}/genomic_gene_coc.bed

    # EXECUTION 

    # .gff to .bed [Ajuste de formatação]
    awk 'BEGIN { OFS = "\t" } $2 == "RefSeq" && $3 != "region" { 
            split($9, a, ";")
            split(a[1], b, "=")
            print $1, $4-1, $5, b[2], 0, $7
        }' "$input_gff" > "$pipe_bed"

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
done

for line in $(cat $mfc_list); do
    input_gff=$(find "${dir}/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/${line}" -type f | grep -E ".*\.gff")

    pipe_bed=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/${line}/genomic.bed
    pipe_sor=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/${line}/genomic_sort.bed
    trun_bed=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/${line}/genomic_gene_coc.bed

    # EXECUTION 

    # .gff to .bed [Ajuste de formatação]
    awk 'BEGIN { OFS = "\t" } $2 == "RefSeq" && $3 != "region" { 
            split($9, a, ";")
            split(a[1], b, "=")
            print $1, $4-1, $5, b[2], 0, $7
        }' "$input_gff" > "$pipe_bed"

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
done

    # E N D > > > TO OPERON SELECTION