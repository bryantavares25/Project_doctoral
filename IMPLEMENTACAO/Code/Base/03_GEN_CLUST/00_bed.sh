#!/bin/bash

# SUMARY -> RUN GENE CLUSTERS PIPELINE

# ARCHIVE
dir=/home/regenera
#dir=/home/bryan
org=$dir/Documents/Projects/Project_REGENERA/Project_VANESSA/Bioluminescentes

cd $org/Genome_02v/Genomes/
ls > $org/Genome_02v/Genome_list.txt
genome_list=$(awk '{print $1}' "$org/Genome_02v/Genome_list.txt")

for i in $genome_list; do echo $i; mkdir -p $org/Genome_02v/Gene_clusters/${i}/; done
for i in $genome_list; do echo $i > /home/regenera/Documents/Github/Project_regenera/VAN_projects/strain.txt; /home/regenera/Documents/Github/Project_regenera/VAN_projects/Gene_clusters_step01.sh; done
for i in $genome_list; do echo $i > /home/regenera/Documents/Github/Project_regenera/VAN_projects/strain.txt; /home/regenera/Documents/Github/Project_regenera/VAN_projects/Gene_clusters_step02.sh; done
for i in $genome_list; do echo $i > /home/regenera/Documents/Github/Project_regenera/VAN_projects/strain.txt; /home/regenera/Documents/Github/Project_regenera/VAN_projects/Gene_clusters_step03.sh; done
for i in $genome_list; do echo $i > /home/regenera/Documents/Github/Project_regenera/VAN_projects/strain.txt; /home/regenera/Documents/Github/Project_regenera/VAN_projects/Gene_clusters_step04.sh; done