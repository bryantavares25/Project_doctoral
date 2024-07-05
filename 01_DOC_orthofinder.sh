#!/bin/bash

genomes=(MHP_11 MHP_168)
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
