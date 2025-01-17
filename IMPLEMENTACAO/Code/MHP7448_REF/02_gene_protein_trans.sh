#!/bin/bash

# Arquivo FASTA de entrada
file="/home/bryan/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/strains/ATCC27716/Use/GCF_000367185.1/cds_from_genomic.fna"

dir=/home/lgef
#dir=/home/bryan

for i in si; do  ; done

input_fasta=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Code/MHP7448_REF/MFC_ATCC27716_proteins.fasta
id_map=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Code/MHP7448_REF/Test.txt
output_fasta=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Code/MHP7448_REF/MFC_ATCC27716_proteins_trans.fasta

# Criar o novo arquivo com IDs alterados
awk '
    BEGIN {
        while ((getline < "'"$id_map"'") > 0) {
            map[$2] = $1
        }
        close("'"$id_map"'")
    }
    # Se for uma linha de cabeçalho FASTA (">"), substitua o ID se ele estiver no mapa
    /^>/ {
        split($1, id, ">")
        if (id[2] in map) {
            print ">" map[id[2]]
        } else {
            print $0
        }
        next
    }
    # Caso contrário, imprima a sequência normalmente
    {
        print $0
    }
' "$input_fasta" > "$output_fasta"

echo "IDs atualizados e salvos em $output_fasta"
