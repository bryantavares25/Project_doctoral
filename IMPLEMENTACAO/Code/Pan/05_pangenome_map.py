import subprocess

# Caminho do arquivo FASTA
input_fasta = "sequences.faa"
output_file = "interproscan_output"

# Comando para rodar InterProScan
cmd = [
    "interproscan.sh", "-i", input_fasta, "-o", output_file,
    "-f", "TSV", "--goterms"
]

# Executa o comando no terminal
subprocess.run(cmd)
