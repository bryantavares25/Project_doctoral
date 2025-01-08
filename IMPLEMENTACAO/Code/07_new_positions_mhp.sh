#!/bin/bash

# Folders
dir=/home/lgef
#dir=/home/bryan

direc_mhp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae
mhp_table=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt

# Input
mhp_genome_fna=$(find "${direc_mhp}/strains/${file}/Use/" -type f -path "*/G*.1/G*.fna")
mhp_genome_gff=$(find "${direc_mhp}/strains/${file}/Use/" -type f -path "*/G*.1/g*.gff")
mhp_gff_data=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/gff_data.tsv
mhp_gff_location=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/location_data.tsv
mhp_genes_fasta=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/genes_fasta.tsv
mhp_genome_new=$direc_mhp/mult_align/seqs_to_align/$file.fasta
mhp_genes_location=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/genes_location.tsv
mhp_genes_location_clean=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/genes_location_clean.tsv


teste=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/11/gff_data.tsv
testes=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/11/gff_data_to_map.tsv
testes_juntos=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/11/gff_juntos.tsv
# limpar ALL_FASTA.fasta # CURADORIA MANUAL # a ordem seguida é do arquivo .gff (podemos melhorar a confiabilidade)

genes_location_clean.fasta=$dir
ALL_FASTA_CLEANED_AWK.tsv=
ALL_FASTA_CLEANED_AWK.tsv=
teste_03.tsv=
arquivo_junto.tsv=
genomic.gff=
genomic_novo.gff=

for file in $(cat $mhp_list); do
    # Folders
    mhp_gff_data=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/gff_data.tsv
    mhp_gff_strand=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/gff_strand.tsv
    mhp_genes_location_clean=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/genes_location_clean.tsv
    mhp_genes_location_clean_strand=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/genes_location_clean_strand.tsv
    mhp_genes_location_strand_complete=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/genes_strand_complete.tsv
    $mhp_genes_location_strand_final=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M_hyopneumoniae/$file/genes_strand_final.tsv

    # Criar arquivos para estabelecer a strand correta
    awk 'BEGIN {OFS="\t"} {print $1, $2, $3, $4}' $mhp_gff_data > $mhp_gff_strand
    awk 'BEGIN {OFS="\t"} NR%2 == 0 {print $1, $4, $5, $6}' $mhp_genes_location_clean > $mhp_genes_location_clean_strand
    # Colando arquivos   
    paste $mhp_gff_strand $mhp_genes_location_clean_strand > $mhp_genes_location_strand_complete
    # Calculando final strand
    awk 'BEGIN {OFS="\t"} {
        if ($6 == "+") {
            print $0, $2
        } else {
            if ($2 == "+") sign = "-" 
            else if ($2 == "-") sign = "+"
            print $0, sign
        }
    }' $mhp_genes_location_strand_complete > $mhp_genes_location_strand_final



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

# END > > > 
# GENOMES TO GENE_CLUSTERS
#A partir do genomic_novo_gff gerado, será possível prosseguir para as análises estruturais