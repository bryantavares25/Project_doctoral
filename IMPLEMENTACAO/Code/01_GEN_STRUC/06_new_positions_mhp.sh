#!/bin/bash

#conda init bash

# START > > > ZERO

# ARCHIVE

# Folders
#dir=/home/lgef
dir=/home/bryan

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
        for (i in a) {
            split(a[i], field, "=")
            if (field[1] == "gene_biotype") {
                print $1, $7, $4, $5, b[2], field[2]
            }
        }
    }' "$mhp_genome_gff" > "$mhp_gff_data"

    # $sequence_region $start $end
    awk 'BEGIN {OFS="\t"} {print $1, $3 -1, $4}' "$mhp_gff_data" > "$mhp_gff_location"
    # Recuperar as sequencias de nucleotídeos de todos os genes conforme localização
    seqtk subseq "$mhp_genome_fna" "$mhp_gff_location" > "$mhp_genes_fasta"
    # Recuperar a nova localização das sequenciais no genoma montado
    sequence=$(awk '!/^>/' "$mhp_genes_fasta")
    echo "A" >> "$mhp_genes_location"
    for i in $sequence; do
        seqkit locate -i -p "$i" "$mhp_genome_new" >> "$mhp_genes_location"
    done
    
    #cp $mfc_genes_location $mfc_genes_location_clean  # DANGER - Substitui arquivo curado manualmente
    
    echo $file
done

# END > > > 
# GENOMES TO GENE_CLUSTERS
#A partir do genomic_novo_gff gerado, será possível prosseguir para as análises estruturais


#awk 'BEGIN {
#    OFS = "\t"  # Define o separador de saída como tabulação
#}

# Função para extrair o valor de um campo específico
#function extract_value(field, separator,   parts) {
#    split(field, parts, separator)
#    return parts[2]
#}

# Processa apenas as linhas onde a segunda coluna é "RefSeq" e a terceira não é "Region"
#$2 == "RefSeq" && $3 != "Region" {
#    split($9, a, ";")  # Divide o nono campo em subcampos separados por ";"
#    split(a[1], b, "-")  # Divide o primeiro subcampo para obter o ID

    # Itera sobre os subcampos para encontrar o campo "gene_biotype"
#    for (i in a) {
#        if (a[i] ~ /^gene_biotype=/) {
#            gene_biotype = extract_value(a[i], "=")
#            break  # Sai do loop assim que encontrar o campo desejado
#        }
#    }
#
    # Se o gene_biotype foi encontrado, imprime a linha formatada
#    if (gene_biotype != "") {
#        print $1, $7, $4, $5, b[2], gene_biotype
#    }
#}' "$mhp_genome_gff" > "$mhp_gff_data"
