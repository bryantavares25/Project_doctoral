import sys
from Bio import AlignIO

input_handle = "IMPLEMENTACAO/Code/alignment.maf"
output_handle = "IMPLEMENTACAO/Code/testet.mauve"

alignments = AlignIO.parse(input_handle, "maf")
AlignIO.write(alignments, output_handle, "mauve")
