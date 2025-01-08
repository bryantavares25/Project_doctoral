#!/bin/bash

# Folders
dir=/home/lgef
#dir=/home/bryan

direc_mhp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae
mhp_table=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_table.tsv # Curadoria manual
mhp_list=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_list.txt
mhp_temp=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/mhp_result.txt

# limpar ALL_FASTA.fasta # CURADORIA MANUAL # a ordem seguida é do arquivo .gff (podemos melhorar a confiabilidade)

genes_location_clean.fasta=$dir
ALL_FASTA_CLEANED_AWK.tsv=
ALL_FASTA_CLEANED_AWK.tsv=
teste_03.tsv=
arquivo_junto.tsv=
genomic.gff=
genomic_novo.gff=

# Pegar as linhas pares e jogar o resultado dentro do outro arquivo
awk 'BEGIN {OFS="\t"} NR%2 == 0 {print $1, $4, $5, $6}' ALL_FASTA_CLEANED.fasta > ALL_FASTA_CLEANED_AWK.tsv

# Criar arquivo base like teste_03.tsv
awk 'BEGIN {OFS="\t"} {print $1, $4, $5, $7}'


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