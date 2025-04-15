#!/bin/bash

t=(GC_00000724 GC_00000725)
for i in ${t[@]}; do grep -o "GO:[0-9]\{7\}" interproscan_${i}.tsv | sort -u | awk '{print "${$i}\t" $0}' > test.tsv; done

#t=(GC_00000724 GC_00000725)
#for i in "${t[@]}"; do
#    grep -o "GO:[0-9]\{7\}" interproscan_${i}.tsv | sort -u | awk -v gc="$i" '{print gc "\t" $0}' > test_${i}.tsv
#done

#t=(GC_00000724 GC_00000725)
#> test.tsv  # limpa o arquivo antes
#for i in "${t[@]}"; do
#    grep -o "GO:[0-9]\{7\}" interproscan_${i}.tsv | sort -u | awk -v gc="$i" '{print gc "\t" $0}' >> test.tsv
#done

t=(GC_00000724 GC_00000725)
for i in ${t[@]}; do grep -o "GO:[0-9]\{7\}" interproscan_${i}.tsv | sort -u | awk -v gc="$i" '{print gc "\t" $0}' >> MHP_interpro_db.tsv; done

# # # # #
#  MHP  #
# # # # # 


# # # # #
#  MFC  #
# # # # # 


# # # # # # # #
#   MHP-MFC   #
# # # # # # # #