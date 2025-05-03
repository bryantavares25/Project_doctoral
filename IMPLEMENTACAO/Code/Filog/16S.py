from Bio import SeqIO
import os

t = ["GCF_000013765.1"]

gbff_dir = "/home/bryantavares/Documents/Projeto_ECOVIAS_ESPECIENOVA_REG000848/"

for i in t:
    try:
        fasta_in = os.path.join(gbff_dir, f"{i}_16S_rRNA_sequences.fasta")
        fasta_out = os.path.join(gbff_dir, f"{i}_16S_rRNA_named.fasta")

        species_name = None
        strain_name = None

        # Procurar o arquivo .gbff correspondente
        gbff_file = os.path.join(gbff_dir, f"{i}_genomic.gbff")
        if not os.path.exists(gbff_file):
            gbff_file = os.path.join(gbff_dir, f"{i}.gbff")

        if not os.path.exists(gbff_file):
            print(f"Arquivo .gbff não encontrado para {i}")
            continue

        for record in SeqIO.parse(gbff_file, "genbank"):
            full_name = record.annotations.get("organism", None)
            species_name = "_".join(full_name.split()[:2]) if full_name else None
            strain_name = record.annotations.get("strain", None)

            if not strain_name:
                for feature in record.features:
                    if feature.type == "source":
                        strain_name = feature.qualifiers.get("strain", [None])[0]
            break  # Apenas o primeiro registro

        if not species_name:
            print(f"Espécie não encontrada para {i}")
            continue

        strain_name = strain_name.replace(" ", "_") if strain_name else "no_strain"
        new_id = f"{species_name}_{strain_name}"

        records = list(SeqIO.parse(fasta_in, "fasta"))
        if records:
            record = records[0]
            record.id = new_id
            record.description = ""
            SeqIO.write([record], fasta_out, "fasta")
            print(f"{i}: sequência renomeada como {new_id}")
        else:
            print(f"{i}: nenhum registro no fasta {fasta_in}")
    except Exception as e:
        print(f"Erro com {i}: {e}")
        print("Bora pra próxima...")

print("✅ Nomeação concluída.")
