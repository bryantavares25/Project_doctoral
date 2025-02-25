#!/bin/bash

#pangenome worflow

# Do GBFF to contigs.fa | external-functions | external-gene-calls
anvi-script-process-genbank --input genomic.gbff -O MF3

