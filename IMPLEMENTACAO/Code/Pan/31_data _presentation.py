#!python3

import pandas as pd

# # # # # MHP

mhp = "/home/bryantavares/Documents/GitHub/Project_doctoral/Data/01_MHP_fractions_classified.csv"
df = pd.read_csv(mhp)

layers = {
    'Core': 'og_mhp_core.csv',
    'Shell': 'og_mhp_shell.csv',
    'Singletons': 'og_mhp_singletons.csv'
}

for layer, output_file in layers.items():
    gene_clusters = df[df['Distribution layer'] == layer]['Gene clusters'].unique()
    pd.DataFrame({'Gene clusters': gene_clusters}).to_csv(output_file, index=False, header=False)
    print(f"{layer}: {len(gene_clusters)}")

# # # # # MHP

mfc = "/home/bryantavares/Documents/GitHub/Project_doctoral/Data/01_MFC_fractions_classified.csv"
df = pd.read_csv(mfc)

layers = {
    'Core': 'og_mfc_core.csv',
    'Shell': 'og_mfc_shell.csv',
    'Singletons': 'og_mfc_singletons.csv'
}

for layer, output_file in layers.items():
    gene_clusters = df[df['Distribution layer'] == layer]['Gene clusters'].unique()
    pd.DataFrame({'Gene clusters': gene_clusters}).to_csv(output_file, index=False, header=False)
    print(f"{layer}: {len(gene_clusters)}")