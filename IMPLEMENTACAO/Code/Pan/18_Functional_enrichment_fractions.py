from goatools.obo_parser import GODag
from goatools.associations import read_gaf
from goatools.go_enrichment import GOEnrichmentStudy
from collections import defaultdict

# === 1. Load GO DAG ===
obodag = GODag("/home/lgef/Bionfo_doc_analyses/go-basic.obo")

# === 2. Read GO annotations ===
gene2go = defaultdict(set)
annotation_file = "/home/lgef/Bionfo_doc_analyses/ANVIO_MHP_MFC/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/MHP_MFC_interpro_db.tsv"

with open(annotation_file, "r") as f:
    for line in f:
        parts = line.strip().split("\t")
        if len(parts) >= 2:
            gene, go_id = parts[0], parts[1]
            gene2go[gene].add(go_id)

# === 3. Read study genes ===
study_genes_file = "/home/lgef/Bionfo_doc_analyses/ANVIO_MHP_MFC/GENBANK-METADATA/03_PAN/SUMMARY/FRACTIONS/fraction_shell_cloud.txt"
study_genes = set()

with open(study_genes_file, "r") as f:
    for line in f:
        gene = line.strip()
        if gene:
            study_genes.add(gene)

# === 4. Define background population ===
population_genes = list(gene2go.keys())  # Convert to list

# Check for missing genes
missing_genes = [gene for gene in study_genes if gene not in gene2go]
if missing_genes:
    print(f"Warning: {len(missing_genes)} study genes not found in background population")

# === 5. Perform GO enrichment analysis ===
goea = GOEnrichmentStudy(
    pop=population_genes,          # Changed from population_genes
    assoc=gene2go,                 # Changed from gene2go
    obo_dag=obodag,                # Changed from obodag
    alpha=0.5,
    methods=['fdr_bh', 'bonferroni', 'sidak', 'holm'],
    propagate_counts=True,
    min_ratio=0.2
)

# Run study
results = goea.run_study(study_genes)

#
# REMOÇÃO DE GENE
# study_genes = [gene for gene in study_genes if gene in gene2go]
#

# === 6. Print and save results ===
output_file = "go_enrichment_results.tsv"
with open(output_file, "w") as f:
    f.write("GO\tTerm\tP-value\tFDR\tStudy\tPopulation\n")
    for r in results:
        if r.p_fdr_bh < 0.5:
            line = f"{r.GO}\t{r.name}\t{r.p_uncorrected:.3e}\t{r.p_fdr_bh:.3e}\t{r.study_count}\t{r.pop_count}\n"
            print(line.strip())
            f.write(line)

print(f"\nResults saved to {output_file}")