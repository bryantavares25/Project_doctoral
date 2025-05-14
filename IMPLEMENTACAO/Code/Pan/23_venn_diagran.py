from matplotlib_venn import venn3
import matplotlib.pyplot as plt

set1 = {"geneA", "geneB", "geneC", "geneX"}
set2 = {"geneC", "geneD", "geneE"}
set3 = {"geneB", "geneE", "geneF", "geneG"}

venn3([set1, set2, set3], set_labels=('Amostra 1', 'Amostra 2', 'Amostra 3'))

plt.title("Diagrama de Venn - 3 conjuntos")
plt.show()
