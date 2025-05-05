from goatools.obo_parser import GODag
from goatools.go_enrichment import GOEnrichmentStudy
from goatools.semantic import semantic_similarity
from collections import defaultdict

dir = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/"

# === 1. Carregar Ontologia GO ===
obodag = GODag(f"{dir}go.obo")

# === 2. Ler anotações GO (gene → GO terms), corrigindo GO obsoletos ===
gene2go = defaultdict(set)
input_db = f"{dir}ANVIO_MHP/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/MHP_interpro_db.tsv"

with open(input_db, "r") as f:
    for line in f:
        parts = line.strip().split("\t")
        if len(parts) >= 2:
            gene, go_id = parts[0], parts[1]
            if go_id in obodag:
                term = obodag[go_id]
                if term.is_obsolete:
                    if hasattr(term, "replaced_by") and term.replaced_by:
                        go_id = term.replaced_by[0] if isinstance(term.replaced_by, list) else term.replaced_by
                        term = obodag.get(go_id, None)
                        if term is None or term.is_obsolete:
                            continue
                    else:
                        continue
                if term.depth >= 5:  # Filtra termos muito genéricos
                    gene2go[gene].add(go_id)


# === 3. Carregar genes da FRAÇÃO SHELL (study set) ===
study_genes = set()
input_study = f"{dir}ANVIO_MHP/GENBANK-METADATA/03_PAN/SUMMARY/FRACTIONS/03_fraction_core.txt"
f = open(input_study, "r")
for line in f:
    gene = line.strip()
    if gene:
        study_genes.add(gene)
f.close()

# Filtrar genes anotados
study_genes = [gene for gene in study_genes if gene in gene2go]
print(f"Genes no estudo após filtro: {len(study_genes)}")

# === 4. Carregar genes da FRAÇÃO CORE (population set) ===
population_genes = set()
input_pop = f"{dir}ANVIO_MHP/GENBANK-METADATA/03_PAN/SUMMARY/FRACTIONS/03_fraction_core.txt"
f = open(input_pop, "r")
for line in f:
    gene = line.strip()
    if gene:
        population_genes.add(gene)
f.close()

# Filtrar genes anotados
population_genes = [gene for gene in population_genes if gene in gene2go]
print(f"Genes no background após filtro: {len(population_genes)}")

# === 5. Enriquecimento funcional GO ===
goea = GOEnrichmentStudy(
    pop=population_genes,
    assoc=gene2go,
    obo_dag=obodag,
    alpha=0.5,  # valor de p desejado
    methods=['fdr_bh'],
    propagate_counts=True
)
results = goea.run_study(study_genes)

# === 6. Agrupar termos semelhantes ===
def group_similar_terms(go_results, obodag, threshold=0.9):
    grouped_terms = defaultdict(list)
    used_terms = set()
    sorted_results = sorted(go_results, key=lambda x: x.p_fdr_bh)
    
    for i, r1 in enumerate(sorted_results):
        if r1.GO in used_terms:
            continue
        grouped_terms[r1.GO].append(r1)
        for j, r2 in enumerate(sorted_results[i+1:]):
            if r2.GO in used_terms:
                continue
            sim = semantic_similarity(r1.GO, r2.GO, obodag)
            if sim is not None and sim >= threshold:
                grouped_terms[r1.GO].append(r2)
                used_terms.add(r2.GO)
    return grouped_terms

grouped_results = group_similar_terms(
    [r for r in results if r.p_fdr_bh < 0.5],
    obodag,
    threshold=0.9
)

# === 7. Escrever resultados em arquivo ===
output_file = f"{dir}Functional_analyses/MHP_core_vs_shell_teste_teste.tsv"
f = open(output_file, "w")
f.write("Parent GO\tParent Term\tCategory\tP-value (FDR)\tStudy Count\tPopulation Count\tSimilar Terms\n")

for parent_go, similar_terms in grouped_results.items():
    parent_term = obodag[parent_go].name
    p_value = min(t.p_fdr_bh for t in similar_terms)
    total_study = sum(t.study_count for t in similar_terms)
    total_pop = sum(t.pop_count for t in similar_terms)
    
    ratio_study = total_study / len(study_genes)
    ratio_pop = total_pop / len(population_genes)
    category = "enriched" if ratio_study > ratio_pop else "purified"
    
    similar_terms_str = ", ".join(f"{t.GO} ({obodag[t.GO].name})" for t in similar_terms)
    
    f.write(f"{parent_go}\t{parent_term}\t{category}\t{p_value:.3e}\t{total_study}\t{total_pop}\t{similar_terms_str}\n")
f.close()

print(f"Resultados salvos em: {output_file}")

