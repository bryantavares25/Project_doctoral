#!/bin/bash

#conda init bash

# START > > > ZERO

# ARCHIVE
dir=/home/lgef
#dir=/home/bryan

# INPUT FILE
input_gff=$dir/Documentos/GitHub/Project_doctoral/BIOINFO_TEST/11/genomic.gff

# EXECUTION

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

awk '{print $1, $3 -1, $4}' teste.txt > teste_02.txt

seqtk subseq GCF_002193015.1_ASM219301v1_genomic.fna teste_02.txt > teste.fasta

# # #

#### CORRECT
input_file=/home/bryan/Documentos/GitHub/Project_doctoral/BIOINFO_TEST/11/teste.fasta
sequence=$(awk '!/^>/' "$input_file")
echo "${sequence[@]}" # Exibir a sequência
for i in $sequence; do
    seqkit locate -i -p "$i" /home/bryan/Documentos/GitHub/Project_doctoral/BIOINFO_TEST/11/ALL_GCF_002193015.fna >> /home/bryan/Documentos/GitHub/Project_doctoral/BIOINFO_TEST/11/ALL_FASTA.fasta
done

# limpar ALL_FASTA.fasta # CURADORIA MANUAL


# > > > $1 $4 $5 $6 
awk 'BEGIN {OFS="\t"} NR%2 == 0 {print $1, $5, $6}' ALL_FASTA_CLEANED.fasta > ALL_FASTA_CLEANED_AWK.tsv

#### OUTPUT : FASTA SEQ

#### SUBSTITUIR:
# mapa.tsv > > > NZ_MWWN01000001.1 1 1624 NZ_MWWN01000002.1 2 1625
cat teste_02.txt > teste_03.txt
paste ALL_FASTA_CLEANED_AWK.tsv teste_03.tsv > arquivo_junto.tsv

# Cria o código para construção automática do mapa de substituição

# Substituição
awk 'BEGIN { OFS="\t" }
NR==FNR {
    map[$1 FS $2 FS $3] = $4 FS $5 FS $6
    next
}
{
    key = $1 FS $4 FS $5
    if (key in map) {
        split(map[key], new_values, FS)
        $1 = new_values[1]
        $4 = new_values[2]
        $5 = new_values[3]
    }
    print
}' mapa.tsv genomic.gff > genomic_novo.gff

# END > > > 

# GENOMES TO GENE_CLUSTERS

#A partir do genomic_novo_gff gerado, será possível prosseguir para as análises estruturais
