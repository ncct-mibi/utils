#!/usr/bin/env bash

for f in *.fastq; do
  ./metamaps mapDirectly -t 100 --all -r ~/Downloads/databases/miniSeq+H/DB.fa -q $f -o classification_results_${f%.*}
  ./metamaps classify -t 100 --mappings classification_results_${f%.*} --DB ~/Downloads/databases/miniSeq+H
done


