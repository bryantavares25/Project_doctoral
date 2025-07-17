###

# Do GBFF to contigs.fa | external-functions | external-gene-calls
anvi-script-process-genbank --input genomic.gbff \
    -O MF3


anvi-gen-contigs-database -f contigs-fasta \
    -o contigs-db \
    --external-gene-calls external-gene-calls \
    --ignore-internal-stop-codons


###