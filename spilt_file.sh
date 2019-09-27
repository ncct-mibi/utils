#!/usr/bin/env bash

#count the number of lines in your text file
wc -l yourTextFile

#slit file with split command, for example, each file has 20000 lines. 
split -l 20000 yourTextFile

#another method, use head and tail command, split file into 2 pieces
head -n 20000 yourTextFile > output1
tail -n +20001 yourTextFile > output2
