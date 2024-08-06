#!/usr/bin/env bash

i=$1;
j=$2

echo "--->>>Working on..."${i};

Bifrost build -t 5 -k 31 -i -d -r ${i} -o ${i}.graph; 
Bifrost query -t 5 -e 1 -q ${j} -g ${i}.graph.gfa -o unitig.presence.${i}; 

rm -rf ${i}.graph.gfa;

##TO SAVE DISK SPACE
##rm -rf ${i};

echo ${i} | sed "s:\.fasta$::g" | sed "s:\.fa$::g" > unitig.presence.${i}.out.tsv;

grep -v query_name unitig.presence.${i}.tsv | sort -k1 -n | awk '{print $2}' >> unitig.presence.${i}.out.tsv;
echo "KmerID" > unitig.presence.${i}.head.tsv;
grep -v query_name unitig.presence.${i}.tsv | sort -k1 -n | awk '{print $1}' | sed "s:query\_name:KmerID:g" >> unitig.presence.${i}.head.tsv;

datamash transpose < unitig.presence.${i}.head.tsv > unitig.presence.${i}.header.tsv;
rm -rf unitig.presence.${i}.head.tsv;

datamash transpose < unitig.presence.${i}.out.tsv > unitig.presence.${i}.tmp.tsv;
rm -rf unitig.presence.${i}.out.tsv;

rm -rf unitig.presence.${i}.out.tsv;
