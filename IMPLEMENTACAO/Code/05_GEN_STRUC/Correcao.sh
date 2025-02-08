#!/bin/bash
set -euo pipefail

# START > > > OPERON ORGANIZATION

# ARCHIVE
dir=/home/bryan
#dir=/home/lgef

# INPUT FILE
r=(OG0000011 OG0000072 OG0000078 OG0000100 OG0000145 OG0000169 OG0000215 OG0000248 OG0000278 OG0000306 OG0000359)
t=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters_ort/gene_co_coc.tsv

# EXECUTION
while IFS=$'\t' read -r c1 c2 c3 c4 c5 c6 c7 c8; do
    echo " - Iniciando linha"

    if [[ ${r[*]} =~ $c2 ]]; then
        echo "SoS"
        
        a=$((c5 - 250)) #(( a = c5 - 250 ))
        b=$((c6 + 250)) #(( b = c6 + 250 ))

        local=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomes/
        mhp=M_hyopneumoniae/mult_align/seqs_to_align/$c1.fasta
        mfc=M_flocculare/mult_align/seqs_to_align/$c1.fasta

        if [[ -f $local$mhp ]]; then
            recip=$local$mhp
            m="M_hyopneumoniae"
        elif [[ -f "$local$mfc" ]]; then
            recip=$local$mfc
            m="M_flocculare"
        else
            echo "Erro: Arquivo de referência não encontrado para $c1"
            continue
        fi

        output_fasta="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c1}_${c2}_${c3}_${c4}.fasta"
        output_gff="$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Genomic_structural/${c1}_${c2}_${c3}_${c4}.gff"

        # Recuperação da sequência
        if [[ "$c7" == "+" ]]; then
            seqkit subseq -r "$a:$b" --seq-type "DNA" $recip -o $output_fasta
        else
            seqkit subseq -r "$a:$b" $recip | seqkit seq --reverse --complement > $output_fasta
        fi

        # Construção e atualização do GFF
        gff_dir=$dir/Documentos/GitHub/Project_doctoral/IMPLEMENTACAO/Gene_clusters/$m/$c1
        gff_file=$gff_dir/genomic.gff
        gff_target=$gff_dir/genomic_target.gff

        if [[ ! -f "$gff_file" ]]; then
            echo "Erro: Arquivo GFF não encontrado para $c1"
            continue
        fi

        IFS=',' read -r -a genes <<< $c8
        > "$gff_target"  # Limpa o arquivo antes de adicionar novos dados
        for g in ${genes[@]}; do
            grep -E "ID.*$c1.*RefSeq.*$g" $gff_file >> $gff_target
        done

        tac $gff_target | \
        awk '{temp=$4; $4=$5; $5=temp} 1' | \
        awk -v delta=250 'NR==1 {offset = $4 - delta; $4 = delta; $5 -= offset} NR>1 {$4 -= offset; $5 -= offset} {print}' > $output_gff
    else
        echo "NoN"
    fi
    echo " - Finalizando linha"
done < "$t"
