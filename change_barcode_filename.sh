#!/usr/bin/env bash

prefix=barcode

for filename in barcode*/*.fastq; do
  cp $filename "$prefix"$(echo ${filename%/*} | egrep -o "[1-9]+0*").fastq
done
#rm -r barcode*
