# utils
## rename_file.py
* Rename the Illumina files with a CSV file.
* Usage: `python rename_file.py -csv samples.csv -i illumina_reads_directory/`
## change_barcode_filename.sh
* Rename the FASTQ file with the barcode and copy them outside the barcode folders.
## run_metamaps.sh
* Run MetaMaps.
## split_file.sh
* How to split file with bash command.
## Run `seqkit stats` with GNU parallel (much faster with many files)
If fastq files are in fastq folder, just this:

`ls -d fastq/*fastq.gz | parallel seqkit stats -T -a | sed -n '/file\t/!p'`

The header (that is deleted and has to be added again) for the output is:

`file	format	type	num_seqs	sum_len	min_len	avg_len	max_len	Q1	Q2	Q3	sum_gap	N50	Q20(%)	Q30(%)`
