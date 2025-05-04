from goatools.obo_parser import GODag
from goatools.associations import read_gaf
from goatools.go_enrichment import GOEnrichmentStudy
from goatools.semantic import semantic_similarity, resnik_sim
from collections import defaultdict
import pandas as pd

# ===== CONFIGURAÇÃO =====
dir = "/home/bryantavares/Documents/Doctoral_data/Bionfo_doc_analyses/"
input_db = f"{dir}ANVIO_MHP/GENBANK-METADATA/03_PAN/EXPORT-PROTEINS/Interpro_db/MHP_interpro_db.tsv"
input_study = f"{dir}ANVIO_MHP/GENBANK-METADATA/03_PAN/SUMMARY/FRACTIONS/03_fraction_shell.txt"
output_file = f"{dir}Functional_analyses/MHP_GO_enrichment_results.tsv"
obo_file = f"{dir}go.obo"

# ===== 1. CARREGAR ONTOLOGIA =====
obodag = GODag(obo_file)

# ===== 2. PROCESSAR ANOTAÇÕES =====
def load_annotations(annotation_file, obodag, min_depth=3):
    gene2go = defaultdict(set)
    with open(annotation_file) as f:
        next(f)  # Pular cabeçalho se existir
        for line in f:
            parts = line.strip().split("\t")
            if len(parts) < 2:
                continue
                
            gene, go_id = parts[0], parts[1]
            
            # Verificar termo GO válido
            if go_id not in obodag:
                continue
                
            term = obodag[go_id]
            
            # Pular termos obsoletos
            if term.is_obsolete:
                continue
                
            # Filtrar por profundidade da ontologia
            if term.depth >= min_depth:
                gene2go[gene].add(go_id)
    
    return gene2go

gene2go = load_annotations(input_db, obodag, min_depth=3)

# ===== 3. CARREGAR GENES DE ESTUDO =====
study_genes = set()
with open(input_study) as f:
    for line in f:
        gene = line.strip()
        if gene in gene2go:  # Só incluir genes anotados
            study_genes.add(gene)

print(f"Total genes no estudo: {len(study_genes)}")
print(f"Total genes anotados no background: {len(gene2go)}")

# ===== 4. ANÁLISE DE ENRIQUECIMENTO =====
goea = GOEnrichmentStudy(
    population=list(gene2go.keys()),
    assoc=gene2go,
    obo_dag=obodag,
    alpha=0.05,  # Limiar de significância
    methods=['fdr_bh', 'bonferroni'],  # Múltiplas correções
    propagate_counts=True,
    significance_threshold_method='fdr_bh'
)

# Executar análise
results = goea.run_study(study_genes)

# ===== 5. PROCESSAR RESULTADOS =====
def process_results(go_results, obodag, sim_threshold=0.7):
    # Converter para DataFrame
    df = pd.DataFrame([{
        'GO': r.GO,
        'Term': obodag[r.GO].name,
        'Namespace': obodag[r.GO].namespace,
        'p_uncorrected': r.p_uncorrected,
        'p_fdr_bh': r.p_fdr_bh,
        'p_bonferroni': r.p_bonferroni,
        'study_count': r.study_count,
        'study_ratio': r.study_count/len(study_genes),
        'pop_count': r.pop_count,
        'pop_ratio': r.pop_count/len(gene2go),
        'enrichment': (r.study_count/len(study_genes))/(r.pop_count/len(gene2go))
    } for r in go_results if r.p_fdr_bh < 0.05])  # Filtrar por FDR < 0.05
    
    # Agrupar termos semanticamente similares
    grouped = []
    used_terms = set()
    
    for _, row in df.sort_values('p_fdr_bh').iterrows():
        if row['GO'] in used_terms:
            continue
            
        # Encontrar termos similares
        similar = [row]
        for _, other_row in df.iterrows():
            if other_row['GO'] == row['GO'] or other_row['GO'] in used_terms:
                continue
                
            sim = semantic_similarity(row['GO'], other_row['GO'], obodag)
            if sim and sim >= sim_threshold:
                similar.append(other_row)
                used_terms.add(other_row['GO'])
        
        # Selecionar termo mais significativo do grupo
        main_term = min(similar, key=lambda x: x['p_fdr_bh'])
        grouped.append({
            'representative_GO': main_term['GO'],
            'representative_term': main_term['Term'],
            'namespace': main_term['Namespace'],
            'min_p_fdr_bh': main_term['p_fdr_bh'],
            'n_similar_terms': len(similar),
            'similar_terms': "; ".join(f"{t['GO']} ({t['Term']})" for t in similar),
            'total_study_count': sum(t['study_count'] for t in similar),
            'total_pop_count': sum(t['pop_count'] for t in similar),
            'enrichment_ratio': (sum(t['study_count'] for t in similar)/len(study_genes)) / 
                               (sum(t['pop_count'] for t in similar)/len(gene2go))
        })
    
    return pd.DataFrame(grouped)

results_df = process_results(results, obodag)

# ===== 6. SALVAR RESULTADOS =====
results_df.to_csv(output_file, sep='\t', index=False)
print(f"Resultados salvos em: {output_file}")

# Análise adicional recomendada
print("\nResumo dos resultados significativos:")
print(f"- Total termos GO significativos (FDR<0.05): {len(results_df)}")
print(f"- Termos biológicos mais enriquecidos:")
print(results_df[results_df['namespace']=='biological_process']
      .sort_values('enrichment_ratio', ascending=False).head(5))
print(f"- Termos moleculares mais enriquecidos:")
print(results_df[results_df['namespace']=='molecular_function']
      .sort_values('enrichment_ratio', ascending=False).head(5))