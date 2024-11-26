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
for file in $(cat "$mhp_list"); do
    if ls ${mhp}${file}/GCF* 1> /dev/null 2>&1; then
        cp -r ${mhp}${file}/GCF* ${mhp}${file}/Use/
    elif ls ${mhp}${file}/GCA* 1> /dev/null 2>&1; then
        cp -r ${mhp}${file}/GCA* ${mhp}${file}/Use/
    else
        echo "Nenhum arquivo GCF ou GCA encontrado."
    fi
done

mfc=/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_flocculare/MFC_ncbi_dataset/ncbi_dataset/data/strains/
for file in $(cat "$mfc_list"); do
    if ls ${mfc}${file}/GCF* 1> /dev/null 2>&1; then
        cp -r ${mfc}${file}/GCF* ${mfc}${file}/Use/
    elif ls ${mfc}${file}/GCA* 1> /dev/null 2>&1; then
        cp -r ${mfc}${file}/GCA* ${mfc}${file}/Use/
    else
        echo "Nenhum arquivo GCF ou GCA encontrado."
    fi
done
