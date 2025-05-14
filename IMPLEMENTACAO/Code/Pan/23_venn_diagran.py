'''from matplotlib_venn import venn3, venn3_circles
import matplotlib.pyplot as plt

set1 = {"geneA", "geneB", "geneC", "geneX"}
set2 = {"geneC", "geneD", "geneE"}
set3 = {"geneB", "geneE", "geneF", "geneG"}
set4 = {"geneB", "geneE", "geneF", "geneG"}
set5 = {"geneB", "geneE", "geneF", "geneG"}

venn3([set1, set2, set3, set4, set5], set_labels=('Amostra 1', 'Amostra 2', 'Amostra 3', 'Amostra 4', 'Amostra 5'))

plt.title("Diagrama de Venn - 3 conjuntos")
plt.show()
'''

# import pandas as pd
import pandas as pd
from upsetplot import UpSet, from_memberships
import matplotlib.pyplot as plt
from collections import Counter

# Defina os conjuntos
sets = {
    "Amostra 1": {"geneA", "geneB", "geneC", "geneX"},
    "Amostra 2": {"geneC", "geneD", "geneE"},
    "Amostra 3": {"geneB", "geneE", "geneE", "geneF", "geneG"},
    "Amostra 4": {"geneF", "geneG", "geneH"}
}

# Pegar todos os genes únicos
all_genes = set.union(*sets.values())

# Criar lista de conjuntos (membros) por gene
memberships = []
for gene in all_genes:
    grupo = tuple(sorted([k for k, v in sets.items() if gene in v]))
    memberships.append(grupo)

# Contar cada combinação de grupos
membership_counts = Counter(memberships)

# Criar série do upsetplot
data = from_memberships(membership_counts)

# Plotar
UpSet(data, show_counts=True).plot()
plt.suptitle("UpSet Plot - comparando 4 amostras")
plt.show()