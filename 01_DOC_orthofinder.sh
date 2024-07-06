#!/bin/bash

genomesmhp=(MHP_11 MHP_98 MHP_168 MHP_168L MHP_232 MHP_7422 MHP_7448 MHP_ES2 MHP_ES2L MHP_F72C MHP_J MHP_LH MHP_MHP650 MHP_MHP653 MHP_MHP679 MHP_MHP682 MHP_MHP691 MHP_MHP694 MHP_MHP696 MHP_MHP699 MHP_MHP709 MHP_NCTC10127 MHP_TB1 MHP_UFV01 MHP_UFV02)
genomesmfc=(MFC_ATCC27716 MFC_MF11 MFC_MF18 MFC_MF22 MFC_MF29 MFC_MF30 MFC_MF33 MFC_Ms42)
direc="/home/lgef/Documentos/GitHub/Project_doctoral/Genomes/Mesomycoplasma_hyopneumoniae"

f="/home/lgef/Documentos/GitHub/Project_doctoral/Orthofinder_db"

>WP_002557698.1 MULTISPECIES: serine protease [Mesomycoplasma]
MKKFTKKYGFIGLFLALNLGILLANVALLTNNWIKLNPKVNLESLLKSIVEIKIQKNEEISFATGFVIDNKIITNKHILE
NSDEIDIFYRLANEKDYKKTRIIKISQNYDILSLQLNTQVKNLEIEENFNYADEIFTIGNPHNLGLTISKGIISGTNKLA
NQSFVRTSITIEPGNSGGPVLNTKNKVIGIMTFRLINEKPVQGISFFLPSSQIKEFLNSN

conda activate fastqc
# fastqc
for i in "${seqid[@]}"; do fastqc ${direc}${i}/00_seq_ini/${i}_f* ${direc}${i}/00_seq_ini/${i}_r.* -o ${direc}${i}/01_seq_val/fastqc -t 15; done
# multiqc
for i in "${seqid[@]}"; do multiqc ${direc}${i}/01_seq_val/fastqc -o ${direc}${i}/01_seq_val; done
conda deactivate
