#!/bin/bash

#This script is for the rename of Nanopore files. 

#Check user input.
#$1: a valid path contains .fastq or .fastq.gz files.
#$2: a valid .csv file. Comma-seperated file contains pairs of old barcodes and new barcodes. 
[ -d "$1" ] || exit
[[ $2 =~ \.csv$ ]] || exit

search_path=$(realpath $1)
parent_dir_of_search_path=$(dirname $(realpath $1))
rename_dir=$(dirname $(realpath $1))/fastq_rename
csv_path=$(realpath $2)

find $1 -type d -name 'barcode*' -ls -execdir sh -c 'mkdir -p ../fastq_rename && cat {}/*.fastq > ../fastq_rename/{}.fastq && pigz ../fastq_rename/{}.fastq' sh ";"

while IFS=, read ob nb; do
  mv $rename_dir/"$ob".fastq.gz $rename_dir/"$nb".fastq.gz
done < $csv_path

seqkit stats -a $rename_dir/*.fastq.gz &> $rename_dir/seqkit.txt


