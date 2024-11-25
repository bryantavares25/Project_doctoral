# # # # #

# Organization

# Create folder by species

awk 'NR > 1 && !seen[$5]++ {print $5}' IMPLEMENTAÇÃO/Genomes/mfc_table.tsv > IMPLEMENTAÇÃO/Genomes/mfc_list.txt

ids=()
direc=/home/lgef/Documents/GitHub/Project_doctoral/IMPLEMENTAÇÃO
# /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTAÇÃO/Code/00_organization.bash

for i in "${seqid[@]}"; do mkdir -p {$direc}; done


