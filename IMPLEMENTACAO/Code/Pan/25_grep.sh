si=(Strain_168L Strain_ES2L Strain_J)

for strain in "${si[@]}"; do
    awk -v strain="$strain" '$4 == strain {print $2}' "$tre"
done | sort | uniq -c | awk '$1 == 1 {print $2}' > GC_ids_remove.txt
