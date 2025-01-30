#!/bin/bash

# Inicializa conda, se necessário
# conda init bash

# START > > > ZERO
# Arquivo para gerar clusters de genes a partir de genomas anotados

# Caminhos e pastas
# dir=/home/lgef
dir=/home/bryan

direc_mfc=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare
mfc_table=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_table.tsv # Curadoria manual
mfc_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_list.txt
mfc_temp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mfc_result.txt

output_dir=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_flocculare/
mkdir -p $output_dir

# EXECUÇÃO
for file in $(cat $mfc_list); do
    echo "Processando $file..."
    file_output_dir="$output_dir/$file/Position_update"
    mkdir -p "$file_output_dir"

    # Inputs
    mfc_genome_fna=$(find "${direc_mfc}/strains/${file}/Use/" -type f -path "*/G*.1/G*.fna")
    mfc_genome_gff=$(find "${direc_mfc}/strains/${file}/Use/" -type f -path "*/G*.1/g*.gff")
    mfc_genome_new="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/mult_align/seqs_to_align/$file.fasta"

    # Arquivos de saída
    mfc_gff_data="$file_output_dir/gff_data.tsv"
    mfc_gff_location="$file_output_dir/location_data.tsv"
    mfc_genes_fasta="$file_output_dir/genes_fasta.tsv"
    mfc_genes_location="$file_output_dir/genes_location.tsv"
    mfc_genes_location_clean="$file_output_dir/genes_location_clean.tsv"

    # PRIMEIRA ETAPA: Extrair informações relevantes do arquivo .gff
    awk 'BEGIN {
        OFS = "\t"
    }
    function extract_value(field, separator, parts) {
        split(field, parts, separator)
        return parts[2]
    }
    $2 == "RefSeq" && $3 != "region" {
        split($9, a, ";")
        split(a[1], b, "-")
        for (i in a) {
            if (a[i] ~ /^gene_biotype=/) {
                gene_biotype = extract_value(a[i], "=")
                break
            }
        }
        if (gene_biotype != "") {
            print $1, $7, $4, $5, b[2], gene_biotype
        }
    }' $mfc_genome_gff > $mfc_gff_data

    # SEGUNDA ETAPA: Criar arquivo de localização para subsequências
    awk 'BEGIN {OFS="\t"} {print $1, $3 - 1, $4}' $mfc_gff_data > $mfc_gff_location
    
    echo "SEQTK"
    # TERCEIRA ETAPA: Extrair sequências de genes com seqtk
    seqtk subseq "$mfc_genome_fna" "$mfc_gff_location" > "$mfc_genes_fasta"

    # QUARTA ETAPA: Localizar as sequências extraídas no genoma novo
    id=$(awk '{print $5}' $mfc_gff_data)
    sequence=$(awk '!/^>/' $mfc_genes_fasta)

    echo "SEQTIK"
    paste <(echo "$id") <(echo "$sequence") | while IFS=$'\t' read -r id seq; do
        echo $id >> $mfc_genes_location
        seqkit locate -i -p "$seq" "$mfc_genome_new" >> "$mfc_genes_location"
    done

    # DESCOMENTAR APENAS SE PRECISAR SUBSTITUIR ARQUIVOS MANUALMENTE EDITADOS
    cp "$mfc_genes_location" "$mfc_genes_location_clean"  # DANGER - Substitui arquivo curado manualmente

    echo "Finalizado $file."
done

# END > > > 
# GENOMES TO GENE_CLUSTERS
# A partir do arquivo gerado, será possível prosseguir para análises estruturais