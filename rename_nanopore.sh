#!/bin/bash

#Check user input.
#$1: a valid path contains .fastq or .fastq.gz files.
#$2: a valid .csv file. Comma-seperated file contains pairs of old barcodes and new barcodes. 
[ -d "$1" ] || echo Error: Invalid path. Program exits. || exit
[[ $2 =~ \.csv$ ]] || echo Error: Invalid .csv file. Program exits. || exit

cd $1
mkdir fastq_rename
if [ "$(find . -type d -name "barcode*" )" != "" ]
then
for dir in barcode*/
  do
    dir=${dir%*/}
    count=`ls -1 $dir/*.fastq.gz 2>/dev/null | wc -l`
    if [ $count != 0 ];then
      echo Merge files in $PWD/$dir/ to $PWD/fastq_rename/$dir.fastq.gz | tee fastq_rename/rename.log
      cat $dir/*.fastq.gz > fastq_rename/$dir.fastq.gz
    else
      echo Merge files in $PWD/$dir to $PWD/fastq_rename/$dir.fastq | tee fastq_rename/rename.log
      cat $dir/*.fastq > fastq_rename/$dir.fastq
      echo Compress $PWD/fastq_rename/$dir.fastq to $PWD/fastq_rename/$dir.fastq.gz | tee fastq_rename/rename.log
      pigz fastq_rename/$dir.fastq
      #rm -rf *.fastq
    fi
  done
fi

while IFS=, read -r ob nb
do
  echo rename $PWD/fastq_rename/$ob.fastq.gz to $PWD/fastq_rename/$nb.fastq.gz | tee fastq_rename/rename.log
  mv fastq_rename/$ob.fastq.gz fastq_rename/$nb.fastq.gz
done < $2

echo Running seqkit | tee fastq_rename/rename.log
seqkit stats -a fastq_rename/*.fastq.gz &> fastq_rename/seqkit.txt
echo Finished | tee fastq_rename.log
