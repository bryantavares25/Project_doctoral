#!/bin/bash

dir=/home/lgef/
mhp=Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae

#/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/strains/11/Use/GCF_002193015.1/protein.faa

#interproscan

### ANVIO

anvi-get-sequences-for-gene-clusters \
  -p YOUR-PAN-DB.db \
  -o output_protein_seqs.fa \
  --external-genomes external-genomes.txt \
  --get-aa-sequences

###

#!/bin/bash

input="proteins.fasta"

while read -r line; do
    if [[ $line == ">"* ]]; then
        # Extrai o GC_ID do cabeçalho, ex: GC_00000142
        gc_id=$(echo "$line" | grep -oP 'gene_cluster:\KGC_[^|]+')
        # Remove o > do cabeçalho
        header=$line
    else
        # Salva a sequência no arquivo correspondente ao GC
        echo "$header" >> "${gc_id}.faa"
        echo "$line" >> "${gc_id}.faa"
    fi
done < "$input"

####

#!/bin/bash

input="proteins.fasta"

while read -r line; do
    if [[ $line == ">"* ]]; then
        # Extrai o GC_ID do cabeçalho
        gc_id=$(echo "$line" | grep -oP 'gene_cluster:\KGC_[^|]+')

        # Se não encontrar GC_ID, ignora
        if [[ -z $gc_id ]]; then
            gc_id=""
            header=""
            continue
        fi

        header="$line"
    else
        # Remove os traços da sequência
        clean_seq=$(echo "$line" | tr -d '-')

        # Só escreve se o GC_ID for válido
        if [[ -n $gc_id ]]; then
            echo "$header" >> "${gc_id}.faa"
            echo "$clean_seq" >> "${gc_id}.faa"
        fi
    fi
done < "$input"

