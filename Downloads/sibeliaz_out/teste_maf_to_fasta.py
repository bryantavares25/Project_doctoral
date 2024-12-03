# Input MAF file
input_maf = "/home/bryan/Documentos/GitHub/Project_doctoral/Downloads/sibeliaz_out/alignment.maf"  # Replace with your MAF file

# Output directory for individual FASTA files
output_dir = "/home/bryan/Documentos/GitHub/Project_doctoral/Downloads/sibeliaz_out/"


from Bio.AlignIO.MafIO import MafIterator
from Bio import SeqIO

# Path to your MAF file
input_maf = "/home/bryan/Documentos/GitHub/Project_doctoral/Downloads/sibeliaz_out/alignment.maf"
output_prefix = "/home/bryan/Documentos/GitHub/Project_doctoral/Downloads/sibeliaz_out/output_block_"

from Bio.AlignIO.MafIO import MafIterator
from Bio import SeqIO

# Open the MAF file for reading
with open(input_maf) as maf_file:
    for i, alignment in enumerate(MafIterator(maf_file)):
        output_fasta = f"{output_prefix}{i + 1}.fasta"
        
        # Process alignment block
        with open(output_fasta, "w") as fasta_file:
            for record in alignment:
                # Create FASTA record with ID and sequence
                fasta_entry = f">{record.id}\n{record.seq}\n"
                fasta_file.write(fasta_entry)
        print(f"Saved block {i + 1} IDs and sequences to {output_fasta}")
