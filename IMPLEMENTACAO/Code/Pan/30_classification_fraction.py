#!python3

# Importação de bibliotecas
import pandas as pd

# Definição
def classify_type(row):
    functional = row["Functional homogeneity index"]
    geometric = row["Geometric homogeneity index"]
    
    if functional < 1 and geometric == 1:
        return "Functional"
    elif functional == 1 and geometric < 1:
        return "Geometric"
    elif functional < 1 and geometric < 1:
        return "Functioal and Geometric"
    else:
        return "" # ou outro valor padrão

# Importação de dados
file="/home/lgef/Downloads/01_MX_fractions.csv"
df = pd.read_csv(file, delimiter=',')

# Aplicar a função e criar a coluna Type
df["Type"] = df.apply(classify_type, axis=1)

# Salvar o DataFrame modificado (opcional)
output_file = "/home/lgef/Downloads/01_MX_fractions_classified.csv"
df.to_csv(output_file, index=False)

# Mostrar o DataFrame
print(df)
