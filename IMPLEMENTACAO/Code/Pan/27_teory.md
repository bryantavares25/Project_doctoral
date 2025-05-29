```mermaid

Pangenoma
Grupo gênico
Gene
Transcrição
mRNA
Tradução
Proteína
Modificações pós-traducionais
Proteoformas

##### Artigo > Anvi’o: an advanced analysis and visualization platform for ’omics data
##### Artigo > Linking pangenomes and metagenomes: the Prochlorococcus metapangenome
##### Artigo > Reconstructing organisms in silico: genome-scale models and their emerging applications

##### POR Gene ID
> ANVIO PROVIDE DATA > | Espécie OG | Indice de homogeneidade
> ANVIO PROVIDE DATA > | Comparative OG

gene_ID | protein
gene-ID | specie | strain < GENOME >
gene-ID | og-specie | hi-specie < ANVIO-SPECIE >
gene-ID | og-comparative | HI-comparative < ANVIO-COMPARATIVE >
gene-ID | sequenciamontante | sequenciajusante < PIPELINE-REMONTAGEM >
gene-ID | unidadetranscricionalpotencial [ordem dos genes] < PIPELINE-REMONTAGEM >

if gene_01 and gene_02 TEM igual a Espécie e Linhagem e OG-Espécie podemos considerar que eles são parálogos (CRIA GRUPO DE PARÁLOGOS) > PG ex. PG_001


pan-fractions -> core [unique (hii | hid) | multiple [paralogos] | shell [cloud | singleton]

```

