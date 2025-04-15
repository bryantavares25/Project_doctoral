#!/bin/bash

for i in ${t[@]}; do grep -o "GO:[0-9]\{7\}"  | sort -u | awk '{print "GC_00000724\t" $0}' > test.tsv > test.txt; done

