#!/usr/bin/env bash

i=$1;
j=$2;
t=$3;

Bifrost build -t ${t} -k 31 -i -d -r $i -o UNITIGS -v -a;

cat ${j} | grep -v UNITIG | grep -v KMER | parallel --jobs ${t} --max-args 1 bash bifrost.sh {1} UNITIGS.fasta;

cat `ls unitig.presence.*.header.tsv | head -1` > Unitigs_ALL.matrix.txt;
cat unitig.presence.*.tmp.tsv >> Unitigs_ALL.matrix.txt;

rm -rf unitig.presence.*.header.tsv;
rm -rf unitig.presence.*.tmp.tsv;
rm -rf unitig.presence.*.tsv;

datamash transpose < Unitigs_ALL.matrix.txt > Unitigs_ALL.matrix.T.txt;
