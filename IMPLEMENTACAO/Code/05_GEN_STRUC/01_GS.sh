

for i in $(cat $m_list); do cp $input/$i.fasta | mv $output; done

awk -F'\t' -v OFS='\t' '{split($9, a, ";"); split(a[1], b, "-"); print "", $4, $5, b[2]}' /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Figures/00_BRIG_input/00_MHP_genomic_clean.gff > /home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Figures/00_BRIG_input/00_MHP_genomic_clean.tsv
