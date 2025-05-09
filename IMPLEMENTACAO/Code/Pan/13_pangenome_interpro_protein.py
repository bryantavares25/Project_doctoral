import csv
import re
from collections import defaultdict

def parse_tsv(input_file, output_file):
    go_dict = defaultdict(set)
    
    # Lendo o arquivo de entrada
    infile = open(input_file, 'r')
    reader = csv.reader(infile, delimiter='\t')
    for row in reader:
        if len(row) < 2:
            continue
        id_, go_terms = row[0], row[13]
        if go_terms != "-":
            clean_terms = [re.sub(r"\(.*?\)", "", term) for term in go_terms.split("|")]
            go_dict[id_].update(clean_terms)
    infile.close()
    
    # Escrevendo o arquivo de saída
    outfile = open(output_file, 'w')
    writer = csv.writer(outfile, delimiter='\t')
    for id_, go_terms in go_dict.items():
        writer.writerow([id_, ",".join(sorted(go_terms))])
    outfile.close()

# Exemplo de uso
input_file = "/home/lgef/InterTests/mfc_protein.faa.tsv"
output_file = "/home/lgef/InterTests/mfc_output.tsv"
parse_tsv(input_file, output_file)

