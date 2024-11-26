# # # # #

# Organization

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
direc_mhp=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTAÇÃO/Genomes/M_hyopneumoniae/
direc_mfc=${pcH}Documentos/GitHub/Project_doctoral/IMPLEMENTAÇÃO/Genomes/M_flocculare/
mhp_table="IMPLEMENTAÇÃO/Genomes/mhp_table.tsv"
mhp_list="IMPLEMENTAÇÃO/Genomes/mhp_list.txt"
mhp_temp="IMPLEMENTAÇÃO/Genomes/mhp_result.txt"
mfc_table="IMPLEMENTAÇÃO/Genomes/mfc_table.tsv"
mfc_list="IMPLEMENTAÇÃO/Genomes/mfc_list.txt"
mfc_temp="IMPLEMENTAÇÃO/Genomes/mfc_result.txt"

# In collumn
awk -F'\t' 'NR > 1 && !seen[$5]++ {print $5}' "$mhp_table" > "$mhp_list"
awk -F'\t' 'NR > 1 && !seen[$5]++ {print $5}' "$mfc_table" > "$mfc_list"

# Create folder by species
while IFS= read -r line; do a=$line; mkdir -p ${direc_mhp}${a}/Use; done < "$mhp_list"
while IFS= read -r line; do a=$line; mkdir -p ${direc_mfc}${a}/Use; done < "$mfc_list"

# Move files
while IFS= read -r line; do
    a=$line
    awk -v id="$a" '$5 == id { print $1}' "$input_file" > "$output_file"
    while IFS= read -r line; do
        echo $line
        b=$line
        mv ${i}MHP_ncbi_dataset/ncbi_dataset/data/${line} ${direc_mhp}${a}
    done < "$output_file"
done < "$mhp_list"

while IFS= read -r line; do
    a=$line
    awk -v id="$a" '$5 == id { print $1}' "$input_file" > "$output_file"
    while IFS= read -r line; do
        echo $line
        b=$line
        mv ${direc_mfc}MFC_ncbi_dataset/ncbi_dataset/data/${line} ${direc_mfc}${a}
    done < "$output_file"
done < "$mfc_list"

# /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTAÇÃO/Code/00_organization.bash
#for i in "${seqid[@]}"; do ; done
#for i in ; do mv {$direc}Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/**GCA_000008205.1**; done