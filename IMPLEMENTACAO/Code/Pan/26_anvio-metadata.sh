
anvi-import-misc-data TESTE.txt \
  -p MHP_MFC-PAN-PAN.db \
  --target-data-table layers \
  --category grupo

anvi-export-misc-data -p meu_pan-PAN.db --target-data-table layers

anvi-display-pan -p meu_pan-PAN.db
