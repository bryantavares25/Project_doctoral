#!/bin/bash

#pangenome worflow

# Preparação para rodar workflow
# Banco de dados para anotação funcional
anvi-setup-ncbi-cogs
# Banco de dados para classificação taxonômica
anvi-setup-scg-taxonomy

# Download NCBI genomes
# INSTALL > conda install bioconda::ncbi-genome-download
#   Total
ncbi-genome-download bacteria -g "Mesomycoplasma hyopneumoniae" --metadata MHP-NCBI-METADATA.txt -F all
#   Pan
ncbi-genome-download bacteria -g "Mesomycoplasma hyopneumoniae" --metadata MHP-NCBI-METADATA.txt
#   Total
ncbi-genome-download bacteria -g "Mesomycoplasma flocculare" --metadata MFC-NCBI-METADATA.txt -F all
#   Pan
ncbi-genome-download bacteria -g "Mesomycoplasma flocculare" --metadata MFC-NCBI-METADATA.txt

# INPUT > MHP-NCBI-METADATA.txt
anvi-script-process-genbank-metadata -m MHP-NCBI-METADATA.txt -o GENBANK-METADATA
anvi-script-process-genbank-metadata -m MFC-NCBI-METADATA.txt -o GENBANK-METADATA
# OUTPUT > fasta-input.txt | functions.txt | external-gene-calls.txt | contigs-fasta.fa
# fasta-input > name	path	external_gene_calls	gene_functional_annotation

# Ajuste de NCBI_PGAP para prodigal para não ter erro
find -type f -exec sed -i 's/NCBI_PGAP/prodigal/g' {} +

# Ajustar os nomes no arquivo fasta.txt > Strain_YYY

# Ele cria um workflow básico de pangenomica
anvi-run-workflow -w pangenomics --get-default-config PAN-CONFIG.json

# CONFIG.json
'''
{
    "fasta_txt": "fasta.txt",
    "anvi_gen_contigs_database": {
        "--project-name": "{group}",
        "--description": "",
        "--skip-gene-calling": "",
        "--ignore-internal-stop-codons": true,
        "--skip-mindful-splitting": "",
        "--contigs-fasta": "",
        "--split-length": "",
        "--kmer-size": "",
        "--skip-predict-frame": "",
        "--prodigal-translation-table": "4",
        "threads": ""
    },
    "centrifuge": {
        "threads": 2,
        "run": "",
        "db": ""
    },
    "anvi_run_hmms": {
        "run": true,
        "threads": 5,
        "--also-scan-trnas": true,
        "--installed-hmm-profile": "",
        "--hmm-profile-dir": ""
    },
    "anvi_run_kegg_kofams": {
        "run": true,
        "threads": 4,
        "--kegg-data-dir": "",
        "--hmmer-program": "",
        "--keep-all-hits": "",
        "--log-bitscores": "",
        "--just-do-it": ""
    },
    "anvi_run_ncbi_cogs": {
        "run": true,
        "threads": 5,
        "--cog-data-dir": "",
        "--temporary-dir-path": "",
        "--search-with": ""
    },
    "anvi_run_scg_taxonomy": {
        "run": true,
        "threads": 6,
        "--scgs-taxonomy-data-dir": ""
    },
    "anvi_run_trna_scan": {
        "run": false,
        "threads": 6,
        "--trna-cutoff-score": ""
    },
    "anvi_script_reformat_fasta": {
        "run": true,
        "--prefix": "{group}",
        "--simplify-names": true,
        "--keep-ids": "",
        "--exclude-ids": "",
        "--min-len": "",
        "--seq-type": "",
        "threads": ""
    },
    "emapper": {
        "--database": "bact",
        "--usemem": true,
        "--override": true,
        "path_to_emapper_dir": "",
        "threads": ""
    },
    "anvi_script_run_eggnog_mapper": {
        "--use-version": "0.12.6",
        "run": "",
        "--cog-data-dir": "",
        "--drop-previous-annotations": "",
        "threads": ""
    },
    "anvi_get_sequences_for_hmm_hits": {
        "--return-best-hit": true,
        "--align-with": "famsa",
        "--concatenate-genes": true,
        "--get-aa-sequences": true,
        "--hmm-sources": "Bacteria_71",
        "--separator": "",
        "--min-num-bins-gene-occurs": "",
        "--max-num-genes-missing-from-bin": "",
        "--gene-names": "",
        "threads": ""
    },
    "trimal": {
        "-gt": 0.5,
        "additional_params": "",
        "threads": ""
    },
    "iqtree": {
        "threads": 8,
        "-m": "WAG",
        "-bb": 1000,
        "additional_params": ""
    },
    "anvi_pan_genome": {
        "threads": 7,
        "--project-name": "",
        "--genome-names": "",
        "--skip-alignments": "",
        "--align-with": "",
        "--exclude-partial-gene-calls": "",
        "--use-ncbi-blast": "",
        "--minbit": "",
        "--mcl-inflation": "",
        "--min-occurrence": "",
        "--min-percent-identity": "",
        "--description": "",
        "--overwrite-output-destinations": "",
        "--skip-hierarchical-clustering": "",
        "--enforce-hierarchical-clustering": "",
        "--distance": "",
        "--linkage": ""
    },
    "import_phylogenetic_tree_to_pangenome": {
        "tree_name": "phylogeny",
        "--just-do-it": "",
        "threads": ""
    },
    "anvi_compute_genome_similarity": {
        "run": false,
        "additional_params": "",
        "threads": ""
    },
    "gen_external_genome_file": {
        "threads": ""
    },
    "export_gene_calls_for_centrifuge": {
        "threads": ""
    },
    "anvi_import_taxonomy_for_genes": {
        "threads": ""
    },
    "annotate_contigs_database": {
        "threads": ""
    },
    "anvi_get_sequences_for_gene_calls": {
        "threads": ""
    },
    "gunzip_fasta": {
        "threads": ""
    },
    "reformat_external_gene_calls_table": {
        "threads": ""
    },
    "reformat_external_functions": {
        "threads": ""
    },
    "import_external_functions": {
        "threads": ""
    },
    "anvi_run_pfams": {
        "run": "",
        "--pfam-data-dir": "",
        "threads": ""
    },
    "anvi_gen_genomes_storage": {
        "--gene-caller": "",
        "threads": ""
    },
    "anvi_get_sequences_for_gene_clusters": {
        "--gene-cluster-id": "",
        "--gene-cluster-ids-file": "",
        "--collection-name": "",
        "--bin-id": "",
        "--min-num-genomes-gene-cluster-occurs": "",
        "--max-num-genomes-gene-cluster-occurs": "",
        "--min-num-genes-from-each-genome": "",
        "--max-num-genes-from-each-genome": "",
        "--max-num-gene-clusters-missing-from-genome": "",
        "--min-functional-homogeneity-index": "",
        "--max-functional-homogeneity-index": "",
        "--min-geometric-homogeneity-index": "",
        "--max-geometric-homogeneity-index": "",
        "--add-into-items-additional-data-table": "",
        "--concatenate-gene-clusters": "",
        "--separator": "",
        "--align-with": "",
        "threads": ""
    },
    "project_name": "PANGENOME_MHP",
    "internal_genomes": "",
    "external_genomes": "external-genomes-mhp.txt",
    "sequence_source_for_phylogeny": "",
    "output_dirs": {
        "FASTA_DIR": "01_FASTA",
        "CONTIGS_DIR": "02_CONTIGS",
        "PHYLO_DIR": "01_PHYLOGENOMICS",
        "PAN_DIR": "03_PAN",
        "LOGS_DIR": "00_LOGS"
    },
    "max_threads": "8",
    "config_version": "3",
    "workflow_name": "pangenomics"
}
'''

# Rodar o workflow > 1 Thread
anvi-run-workflow -w pangenomics -c PAN-CONFIG.json

anvi-display-pan -p PAN.db -g GENOME.db

anvi-script-add-default-collection -p PAN.db -g GENOME.db

anvi-summarize

### ### ###


