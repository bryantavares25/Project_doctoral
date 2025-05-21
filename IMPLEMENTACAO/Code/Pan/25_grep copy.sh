si=(Strain_168L Strain_ES2L Strain_J)

# Cria uma expressão regular para as linhagens em si
exclude_regex=$(IFS="|"; echo "${si[*]}")

# Coleta todos os IDs que NÃO pertencem às linhagens em si
awk -v regex="$exclude_regex" '$4 !~ regex {print $2}' "$tre" | sort | uniq -c | awk '$1 > 1 {print $2}' > GC_ids_remove.txt
