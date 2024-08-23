from Bio import SeqIO

# Load genome annotation from a GenBank file
genome_file = "path_to_your_genome.gb"
record = SeqIO.read(genome_file, "genbank")

# Extract genes and their orientations
genes = []
for feature in record.features:
    if feature.type == "gene":
        gene_info = {
            "start": feature.location.start,
            "end": feature.location.end,
            "strand": feature.location.strand,
            "gene": feature.qualifiers.get("gene", ["unknown"])[0]
        }
        genes.append(gene_info)

# Find co-oriented genes
co_oriented_genes = []
for i in range(1, len(genes)):
    if genes[i]["strand"] == genes[i - 1]["strand"]:
        co_oriented_genes.append((genes[i - 1]["gene"], genes[i]["gene"]))

# Print co-oriented gene pairs
for gene_pair in co_oriented_genes:
    print(f"Co-oriented genes: {gene_pair[0]} and {gene_pair[1]}")
