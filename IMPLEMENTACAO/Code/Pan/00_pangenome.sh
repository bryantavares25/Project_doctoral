#!/bin/bash

#pangenome worflow

# Download NCBI genomes
#   Total
ncbi-genome-download bacteria -g "Mesomycoplasma hyopneumoniae" --metadata MHP-NCBI-METADATA.txt -F all
#   Util
ncbi-genome-download bacteria -g "Mesomycoplasma hyopneumoniae" --metadata MHP-NCBI-METADATA.txt

ncbi-genome-download bacteria -g "Mesomycoplasma flocculare" --metadata MFC-NCBI-METADATA.txt -F all

#
# INPUT > MHP-NCBI-METADATA.txt
anvi-script-process-genbank-metadata -m MHP-NCBI-METADATA.txt # -o output_folder
# OUTPUT > fasta-input.txt | functions.txt | external-gene-calls.txt | contigs-fasta.fa
# fasta-input > name	path	external_gene_calls	gene_functional_annotation

# Ajuste de NCBI_PGAP para prodigal para não ter erro
find -type f -exec sed -i 's/NCBI_PGAP/prodigal/g' {} +

anvi-run-workflow -w pangenomics --get-default-config PAN-CONFIG.json


anvi-run-workflow -w pangenomics -c PAN-CONFIG.json


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
