# # # # #

# Organization

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
direc_mhp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/
direc_mfc=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/MHP_ncbi_dataset/ncbi_dataset/data/
mhp_table="IMPLEMENTACAO/Genomes/mhp_table.tsv"
mhp_list="IMPLEMENTACAO/Genomes/mhp_list.txt"
mhp_temp="IMPLEMENTACAO/Genomes/mhp_result.txt"
mfc_table="IMPLEMENTACAO/Genomes/mfc_table.tsv"
mfc_list="IMPLEMENTACAO/Genomes/mfc_list.txt"
mfc_temp="IMPLEMENTACAO/Genomes/mfc_result.txt"

# In collumn
awk -F'\t' 'NR > 1 && !seen[$5]++ {print $5}' "$mhp_table" > "$mhp_list"
awk -F'\t' 'NR > 1 && !seen[$5]++ {print $5}' "$mfc_table" > "$mfc_list"

# Create folder by species
while IFS= read -r line; do a=$line; mkdir -p ${direc_mhp}${a}/Use; done < "$mhp_list"
while IFS= read -r line; do a=$line; mkdir -p ${direc_mfc}${a}/Use; done < "$mfc_list"

# Move files
while IFS= read -r line; do
    a=$line
    awk -v id="$a" '$5 == id {print $1}' "$mhp_table" > "$mhp_temp"
    while IFS= read -r line; do
        echo $line
        b=$line
        mv ${direc_mhp}MHP_ncbi_dataset/ncbi_dataset/data/${line} ${direc_mhp}${a}
    done < "$mhp_temp"
done < "$mhp_list"

while IFS= read -r line; do
    a=$line
    awk -v id="$a" '$5 == id {print $1}' "$mfc_table" > "$mfc_temp"
    while IFS= read -r line; do
        echo $line
        b=$line
        mv ${direc_mfc}MFC_ncbi_dataset/ncbi_dataset/data/${line} ${direc_mfc}${a}
    done < "$mfc_temp"
done < "$mfc_list"
