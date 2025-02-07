#!/bin/bash

# START > > > OPERON ORGANIZATION

# ARCHIVE
#dir=/home/bryan
dir="/home/lgef"

# INPUT FILE
r=("OG0000011" "OG0000072" "OG0000078" "OG0000100" "OG0000145" "OG0000169" "OG0000215" "OG0000248" "OG0000278" "OG0000306" "OG0000359")
t="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv"

# EXECUTION
while IFS=$'\t' read -r c1 c2 c3 c4 c5 c6 c7 c8; do
    echo " - Iniciando linha"
    
    # Verifica se c2 está na lista de r
    if [[ " ${r[@]} " =~ " $c2 " ]]; then
        echo "SoS"
        
        # Calcula os valores de a e b
        a=$((c5 - 250))
        b=$((c6 + 250))
        
        # Define os caminhos dos arquivos
        local="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/"
        mhp="M_hyopneumoniae/mult_align/seqs_to_align/$c1.fasta"
        mfc="M_flocculare/mult_align/seqs_to_align/$c1.fasta"

        # Verifica se o arquivo mhp existe, senão usa mfc
        if [[ -f "$local$mhp" ]]; then
            recip="$local$mhp"
        elif [[ -f "$local$mfc" ]]; then
            recip="$local$mfc"
        else
            echo "Arquivo não encontrado para $c1"
            continue
        fi
        
        # Define o caminho para os arquivos de saída
        output_fasta="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c1}_${c2}_${c3}_${c4}.fasta"
        output_gff="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c1}_${c2}_${c3}_${c4}.gff"

        # Verifica a direção da sequência
        if [ "$c7" == "+" ]; then
            # Recupera a sequência
            seqkit subseq -r "$a:$b" --seq-type "DNA" "$recip" -o "$output_fasta"
            
            # Constrói GFF e atualiza
            IFS=',' read -r -a l <<< "$c8"
            for g in "${l[@]}"; do
                grep -E "RefSeq.*$g" "$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic.gff" >> "$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic_target.gff"
            done

            tac "$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic_target.gff" | \
            awk '{temp=$4; $4=$5; $5=temp} 1' | \
            awk 'NR==1 {delta = $4 - 250; $4 = 250; $5 -= delta} NR>1 {$4 -= delta; $5 -= delta} {print}' > "$output_gff"
        else
            # Recupera a sequência reversa e complementar
            seqkit subseq -r "$a:$b" "$recip" | seqkit seq --reverse --complement > "$output_fasta"
            
            # Constrói GFF e atualiza
            IFS=',' read -r -a l <<< "$c8"
            for g in "${l[@]}"; do
                grep -E "RefSeq.*$g" "$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic.gff" >> "$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic_target.gff"
            done

            tac "$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/M*/${c1}/genomic_target.gff" | \
            awk '{temp=$4; $4=$5; $5=temp} 1' | \
            awk 'NR==1 {delta = $4 + 250; $4 = 250; $5 = -$5 +delta} NR>1 {$4 = -$4 + delta; $5 = -$5 + delta} {print}' > "$output_gff"
        fi 
    else
        echo "NoN"
    fi
    echo " - Finalizando linha"
done < "$t"

# END > > >
