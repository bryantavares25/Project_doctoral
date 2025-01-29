#!/bin/bash

#conda init bash

# START > > > ZERO

# ARCHIVE

# Folders
#dir=/home/lgef
dir=/home/bryan

direc_mfc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare
mfc_table=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

mkdir -p $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/

# EXECUTION
for file in $(cat $mfc_list); do

    mkdir -p $dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/

    # Input
    mfc_genome_fna=$(find "${direc_mfc}/strains/${file}/Use/" -type f -path "*/G*.1/G*.fna")
    mfc_genome_gff=$(find "${direc_mfc}/strains/${file}/Use/" -type f -path "*/G*.1/g*.gff")
    mfc_gff_data=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/gff_data.tsv
    mfc_gff_location=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/location_data.tsv
    mfc_genes_fasta=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_fasta.tsv
    mfc_genome_new=$direc_mfc/mult_align/seqs_to_align/$file.fasta
    mfc_genes_location=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_location.tsv
    mfc_genes_location_clean=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/$file/Position_update/genes_location_clean.tsv

    # FIRST >>> Ler arquivo .gff para recuperar informações interessantes
    awk 'BEGIN {OFS="\t"}
    $2 == "RefSeq" && $3 != "Region" {
        split($9, a, ";")
        split(a[1], b, "-")
        for (i in a) {
            split(a[i], field, "=")
            if (field[1] == "gene_biotype") {
                print $1, $7, $4, $5, b[2], field[2]
            }
        }
    }' "$mfc_genome_gff" > "$mfc_gff_data"

    # $sequence_region $start $end
    awk 'BEGIN {OFS="\t"} {print $1, $3 -1, $4}' "$mfc_gff_data" > "$mfc_gff_location"
    
    # Recuperar as sequencias de nucleotídeos de todos os genes conforme localização
    seqtk subseq "$mfc_genome_fna" "$mfc_gff_location" > "$mfc_genes_fasta"
    # Recuperar a nova localização das sequenciais no genoma montado    
    
    #id=$(awk '$5' "$mfc_genes_data")
    #sequence=$(awk '!/^>/' "$mfc_genes_fasta")
    #for i in $sequence; do
    #    seqkit locate -i -p "$i" "$mfc_genome_new" >> "$mfc_genes_location"
    #done

    id=$(awk '$5' "$mfc_genes_data")
    sequence=$(awk '!/^>/' "$mfc_genes_fasta")

    #paste <(echo "$id") <(echo "$sequence") | while IFS=$'\t' read -r id seq; do seqkit locate -i -p "$seq" "$mfc_genome_new" >> "$mfc_genes_location"; done

    paste <(echo "$id") <(echo "$sequence") | while IFS=$'\t' read -r id seq; do echo "$id" "$seq"; done


    #cp $mfc_genes_location $mfc_genes_location_clean  # DANGER - Substitui arquivo curado manualmente

    echo $file
done

# END > > > 
# GENOMES TO GENE_CLUSTERS
#A partir do genomic_novo_gff gerado, será possível prosseguir para as análises estruturais
