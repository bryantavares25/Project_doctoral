#!/bin/bash

# START

# Diretório principal
dir="/home/bryan"
#dir="/home/lgef"

# Lista de OGs de interesse
r=("OG0000011" "OG0000072" "OG0000078" "OG0000100" "OG0000145" "OG0000169" "OG0000215" "OG0000248" "OG0000278" "OG0000306" "OG0000359")

# Caminho do arquivo de entrada
coc="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv"

# Verifica se o arquivo de entrada existe
[[ -f "$coc" ]] || { echo "Erro: Arquivo '$coc' não encontrado!"; exit 1; }

# Cria um arquivo temporário com a lista de OGs
tmpfile=$(mktemp)
printf "%s\n" "${r[@]}" > "$tmpfile"

# Processa o arquivo
while IFS=$'\t' read -r c1 c2 c3 c4 c5 c6 c7 c8; do
    if grep -Fxq $c4 $tmpfile; then
        echo $c8
    else
        echo "No"
    fi
done < "$coc"

# Remove o arquivo temporário
rm -f "$tmpfile"

# END
