#!/bin/bash

conda init bash

conda create -n busco -c bioconda busco
conda create -n fastqc -c bioconda fastqc multiqc
conda create -n megahit -c bioconda megahit
conda create -n memesuite -c bioconda meme
conda create -n orthofinder -c bioconda orthofinder
conda create -n prokka -c bioconda prokka
conda create -n quast -c bioconda quast
conda create -n ragtag -c bioconda ragtag
conda create -n trimmomatic -c bioconda trimmomatic
conda create -n sibelia -c bioconda sibelia
conda create -n mugsy -c bioconda mugsy
conda create -n progressivemauve -c bioconda progressivemauve
