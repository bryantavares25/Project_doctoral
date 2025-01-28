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

mkdir -p $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/

# EXECUTION
for file in $(cat $mhp_list); do

    mkdir -p $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/

    # Input
    mhp_genome_fna=$(find "${direc_mhp}/strains/${file}/Use/" -type f -path "*/G*.1/G*.fna")
    mhp_genome_gff=$(find "${direc_mhp}/strains/${file}/Use/" -type f -path "*/G*.1/g*.gff")
    mhp_gff_data=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/gff_data.tsv
    mhp_gff_location=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/location_data.tsv
    mhp_genes_fasta=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_fasta.tsv
    mhp_genome_new=$direc_mhp/mult_align/seqs_to_align/$file.fasta
    mhp_genes_location=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_location.tsv
    mhp_genes_location_clean=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/Position_update/genes_location_clean.tsv

    # FIRST >>> Ler arquivo .gff para recuperar informações interessantes
    awk 'BEGIN {OFS="\t"}
    $2 == "RefSeq" && $3 != "Region" {
        split($9, a, ";")
        split(a[1], b, "-")
        split(a[4], c, "=")
        split(a[5], d, "=")
        split(a[6], e, "=")
        if (c[1] == "gene_biotype") {
            print $1, $7, $4, $5, b[2], c[2]}
        if (d[1] == "gene_biotype") {
            print $1, $7, $4, $5, b[2], d[2]}
        if (e[1] == "gene_biotype") {
            print $1, $7, $4, $5, b[2], e[2]}
    }' "$mhp_genome_gff" > "$mhp_gff_data"
    # $sequence_region $start $end
    awk 'BEGIN {OFS="\t"} {print $1, $3 -1, $4}' "$mhp_gff_data" > "$mhp_gff_location"
    # Recuperar as sequencias de nucleotídeos de todos os genes conforme localização
    seqtk subseq "$mhp_genome_fna" "$mhp_gff_location" > "$mhp_genes_fasta"
    # Recuperar a nova localização das sequenciais no genoma montado
    sequence=$(awk '!/^>/' "$mhp_genes_fasta")
    for i in $sequence; do
        seqkit locate -i -p "$i" "$mhp_genome_new" >> "$mhp_genes_location"
    done
    
    #cp $mfc_genes_location $mfc_genes_location_clean  # DANGER - Substitui arquivo curado manualmente
    
    echo $file
done

# END > > > 
# GENOMES TO GENE_CLUSTERS
#A partir do genomic_novo_gff gerado, será possível prosseguir para as análises estruturais
