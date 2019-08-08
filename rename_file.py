#!/usr/bin/python

import os,csv,argparse,glob,re

parser = argparse.ArgumentParser()
parser.add_argument('-csv', '--csv', required=True, help='the CSV file')
parser.add_argument('-i', '--input', required=True, help='the input directory')
args = parser.parse_args()

os.chdir(args.input)
with open(args.csv) as csv_file:
  csv_reader = csv.reader(csv_file, delimiter=',')
  for row in csv_reader:
    for filename in glob.glob(f'{row[1]}' + '_*.fastq.gz'):
      os.rename(os.path.basename(filename), f'{row[0]}' + '_' + os.path.basename(filename))
