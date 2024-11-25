# # # # #

# Organization

# Create folder by species

# In collumn
awk -F'\t' 'NR > 1 && !seen[$5]++ {print $5}' IMPLEMENTAÇÃO/Genomes/mhp_table.tsv > IMPLEMENTAÇÃO/Genomes/mhp_list.txt
awk -F'\t' 'NR > 1 && !seen[$5]++ {print $5}' IMPLEMENTAÇÃO/Genomes/mfc_table.tsv > IMPLEMENTAÇÃO/Genomes/mfc_list.txt
# In line
awk '{ printf "%s ", $0 } END { print "" }' IMPLEMENTAÇÃO/Genomes/mhp_list.txt > IMPLEMENTAÇÃO/Genomes/mhp_ids.txt
awk '{ printf "%s ", $0 } END { print "" }' IMPLEMENTAÇÃO/Genomes/mfc_list.txt > IMPLEMENTAÇÃO/Genomes/mfc_ids.txt

awk '{ print "Linha:", $0 }' arquivo.txt

ids=()
direc=/home/lgef/Documents/GitHub/Project_doctoral/IMPLEMENTAÇÃO/
# /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTAÇÃO/Code/00_organization.bash

for i in "${seqid[@]}"; do mkdir -p {$direc}{$ids}; done

for i in ; do mv {$direc}Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/**GCA_000008205.1**; done


