
dir=""
file=""

strain=""

awk -v strain="Strain_11" '$4 == strain {print $2}' $tre | sort -u > GC_ids_Strain_11.txt


si=(Strain_168L Strain_ES2L Strain_J)
for i in ${si[@]}; do
    awk -v strain=$i '$4 == strain {print $2}' $tre | sort -u >> GC_ids_remove.txt;
done

si=(Strain_168L Strain_ES2L Strain_J)
for i in ${si[@]}; do
    awk -v strain=$i '$4 != strain {print $2}' $tre | sort -u >> GC_ids_remove.txt;
done