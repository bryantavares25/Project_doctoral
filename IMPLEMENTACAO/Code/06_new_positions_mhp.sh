#!/bin/bash

#conda init bash

# START > > > ZERO

# ARCHIVE

# Folders
dir=/home/lgef
#dir=/home/bryan

direc_mhp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae
mhp_table=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt

# EXECUTION
for file in $(cat $mhp_list); do

    # Input
    mhp_genome_gff=$direc_mhps/strains/$file/Use/G*/*.fna
    mhp_genome_gff=$direc_mhps/strains/$file/Use/G*/genomic.gff
    mhp_gff_data=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/gff_data.fasta
    mhp_gff_location=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/gff_data.fasta

    mhp_genome_gff=$direc_mhp/mult_align/seqs_to_align/$file.fasta

    # FIRST >>> Ler arquivo .gff para recuperar informações interessantes
    awk '$2 == "RefSeq" && $3 != "Region" {
        split($9, a, ";")
        split(a[1], b, "-")
        split(a[4], c, "=")
        split(a[5], d, "=")
        if (c[1] == "gene_biotype") {
            print $1, $7, $4, $5, b[2], c[2]}
        if (d[1] == "gene_biotype") {
            print $1, $7, $4, $5, b[2], d[2]}
    }' "$mhp_genome_gff" > "$mhp_gff_data"
    # $sequence_region $start $end
    awk '{print $1, $3 -1, $4}' "$mhp_gff_data" > "$mhp_gff_location"
    # Recuperar as sequencias de nucleotídeos de todos os genes conforme localização
    seqtk subseq GCF_002193015.1_ASM219301v1_genomic.fna "$mhp_gff_location" > teste.fasta
    # Recuperar a nova localização das sequenciais no genoma montado
    sequence=$(awk '!/^>/' teste.fasta)
    for i in $sequence; do
        seqkit locate -i -p "$i" ALL_GCF_002193015.fna >> ALL_FASTA.fasta
    done
    # limpar ALL_FASTA.fasta # CURADORIA MANUAL # a ordem seguida é do arquivo .gff (podemos melhorar a confiabilidade)
    # Pegar as linhas pares e jogar o resultado dentro do outro arquivo
    awk 'BEGIN {OFS="\t"} NR%2 == 0 {print $1, $5, $6}' ALL_FASTA_CLEANED.fasta > ALL_FASTA_CLEANED_AWK.tsv
    # Construir MAPA # mapa.tsv > > > NZ_MWWN01000001.1 1 1624 NZ_MWWN01000002.1 2 1625
    paste ALL_FASTA_CLEANED_AWK.tsv teste_03.tsv > arquivo_junto.tsv
    # Substituição da localização
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
done

# END > > > 
# GENOMES TO GENE_CLUSTERS
#A partir do genomic_novo_gff gerado, será possível prosseguir para as análises estruturais
