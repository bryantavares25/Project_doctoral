
dir=""
file=""

strain=""

awk -v strain="Strain_11" '$4 == strain {print $2}' $tre | sort -u > GC_ids_Strain_11.txt