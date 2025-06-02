#!python3

import pandas as pd

file="/home/lgef/Downloads/01_MFC_fractions.csv"
df = pd.read_csv(file, delimiter=';')

print(df)
