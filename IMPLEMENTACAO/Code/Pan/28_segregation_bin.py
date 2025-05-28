

'''
#!/bin/bash
GRUPO_ALVO="nome_do_seu_grupo"  # Substitua pelo nome do grupo desejado

# 1. Exportar a tabela de layers para identificar os genomas do grupo
anvi-export-misc-data -p MHP_MFC-PAN-PAN.db --target-data-table layers -o layers_data.tsv

# 2. Extrair lista de genomas do grupo alvo
GENOMAS=$(awk -v grupo="$GRUPO_ALVO" 'NR==1 {for(i=2;i<=NF;i++) if($i==grupo) col=i} NR>1 && $col==1 {print $1}' layers_data.tsv)

# 3. Exportar TODOS os clusters desses genomas (mesmo que apareçam em outros grupos)
anvi-export-gene-clusters -p MHP_MFC-PAN-PAN.db -o temp_clusters.tsv
grep -wFf <(echo "$GENOMAS" | tr ' ' '\n') temp_clusters.tsv | cut -f1 | sort -u > clusters_$GRUPO_ALVO.ids

# 4. Exportar as sequências
anvi-get-sequences-for-gene-clusters \
  -p MHP_MFC-PAN-PAN.db \
  -c CONTIGS.db \
  --gene-cluster-ids clusters_$GRUPO_ALVO.ids \
  -o genes_$GRUPO_ALVO.fa

# Limpeza
rm temp_clusters.tsv
'''