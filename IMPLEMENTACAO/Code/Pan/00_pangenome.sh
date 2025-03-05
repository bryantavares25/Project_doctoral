#!/bin/bash

#pangenome worflow

# Download NCBI genomes
ncbi-genome-download bacteria -g "Mesomycoplasma hyopneumoniae" --metadata MHP-NCBI-METADATA.txt -F all

ncbi-genome-download bacteria -g "Mesomycoplasma flocculare" --metadata MFC-NCBI-METADATA.txt -F all

# Banco de dados para anotação funcional
anvi-setup-ncbi-cogs
# Banco de dados para classificação taxonômica
anvi-setup-scg-taxonomy


# Do GBFF to contigs.fa | external-functions | external-gene-calls
anvi-script-process-genbank --input genomic.gbff \
    -O MF3


anvi-gen-contigs-database -f contigs-fasta \
    -o contigs-db \
    --external-gene-calls external-gene-calls \
    --ignore-internal-stop-codons


### 
