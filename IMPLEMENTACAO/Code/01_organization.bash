# # # # #

# Organization USE

# Folders
pcH=/home/bryan/
pcL=/home/lgef/
direc_mhp=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/
direc_mfc=${pcL}Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/MFC_ncbi_dataset/ncbi_dataset/data/
mhp_table="IMPLEMENTACAO/Genomes/mhp_table.tsv" # Curadoria manual
mhp_list="IMPLEMENTACAO/Genomes/mhp_list.txt"
mhp_temp="IMPLEMENTACAO/Genomes/mhp_result.txt"
mfc_table="IMPLEMENTACAO/Genomes/mfc_table.tsv" # Curadoria manual
mfc_list="IMPLEMENTACAO/Genomes/mfc_list.txt"
mfc_temp="IMPLEMENTACAO/Genomes/mfc_result.txt"

mhp=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/MHP_ncbi_dataset/ncbi_dataset/data/strains/
for file in "${mhp}*/"; do
    echo $file
    if ls ${file}GCF* 1> /dev/null 2>&1; then
        echo $file
        #cp -r ${file}GCF* ${file}Use/
    elif ls ${file}GCA* 1> /dev/null 2>&1; then
        echo "NO"
        #cp -r ${file}GCA* ${file}Use/
    else
        echo "Nenhum arquivo GCF ou GCA encontrado."
    fi
    echo "\n"
done

mfc=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/MFC_ncbi_dataset/ncbi_dataset/data/strains/
for file in "${mfc[@]}*/"; do
    if ls ${file}ATCC27716/GCF* 1> /dev/null 2>&1; then
        echo "OK"
        #cp -r ${file}ATCC27716/GCF* ${file}ATCC27716/Use/
    elif ls ${file}ATCC27716/GCA* 1> /dev/null 2>&1; then
        echo "NO"
        #cp -r ${file}ATCC27716/GCA* ${file}ATCC27716/Use/
    else
        echo "Nenhum arquivo GCF ou GCA encontrado."
    fi
done
