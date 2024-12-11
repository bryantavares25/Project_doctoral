#!/bin/bash

conda init bash

# START > > > ZERO

# ARCHIVE
dir=/home/lgef
#dir=/home/bryan

# INPUT FILE
input_gff=

# EXECUTION

# Recovery from .gff: seqregion ($1) | strand ($7) | start | ID | gene_biotype | stop > > > file.txt
awk '$2 == "RefSeq" && $3 != "Region" {print $1, $7, $4, $5, $9}; split($9, a, ";"); {print $a}' genomic.gff

awk '$2 == "RefSeq" && $3 != "Region" split($9, a, ";") split(a[1], b, "-") split(a[5], c, "=") {print $1, $7, $4, $5, b[2], c[2]}; ' genomic.gff

awk '$2 == "RefSeq" && $3 != "Region" {
    split($9, a, ";")
    split(a[1], b, "-")
    split(a[4], c, "=")
    split(a[5], d, "=")
    if (c[1] == "gene_biotype") {
        print $1, $7, $4, $5, b[2], c[2]}
    if (d[1] == "gene_biotype") {
        print $1, $7, $4, $5, b[2], d[2]}
}' genomic.gff > teste.txt


# Create the .txt: seqregion | start | stop

# Recovery from .fna with base from .txt and ID: >ID+fasta sequence

# END