from Bio import SeqIO

def xmfa_to_fasta(xmfa_file, output_dir):
    with open(xmfa_file, "r") as xmfa:
        sequences = {}
        current_id = None
        sequence = ""

        # Iterar sobre o arquivo XMFA
        for line in xmfa:
            if line.startswith(">"):  # Quando encontrar um cabeçalho (linha de identificaç
                if current_id:
                    # Armazenar a sequência antes de começar uma nova
                    if current_id not in sequences:
                        sequences[current_id] = sequence
                    else:
                        sequences[current_id] += sequence
                
                # Extrair o novo ID
                current_id = line.split()[-1]
                print(current_id) # O ID está após o ">", então removemos
                sequence = ""  # Resetar a sequência para o novo ID
            elif line.strip():  # Se a linha não for vazia
                sequence += line.strip()  # Adicionar a sequência à variável `sequence`

        # Adicionar a última sequência ao dicionário
        if current_id:
            if current_id not in sequences:
                sequences[current_id] = sequence
            else:
                sequences[current_id] += sequence

        # Escrever cada sequência em um arquivo FASTA
        for seq_id, seq in sequences.items():
            output_file = f"{output_dir}/{seq_id}.fasta"
            with open(output_file, "w") as fasta_file:
                fasta_file.write(f">{seq_id}\n{seq}\n")

# Defina o arquivo XMFA de entrada e o diretório de saída
xmfa_file = "/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniae/mult_align/pm_alignment.xmfa"  # Caminho para o arquivo XMFA
output_dir = "/home/lgef/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/M_hyopneumoniaeflocculare/mult_align/final_alignment/"  # Caminho para o diretório de saída (FASTA)

# Chame a função para converter
xmfa_to_fasta(xmfa_file, output_dir)
