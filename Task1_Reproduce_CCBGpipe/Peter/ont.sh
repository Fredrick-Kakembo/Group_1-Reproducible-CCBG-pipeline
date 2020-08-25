building docker file
docker build -t "ontpipe:v1" ./ 


Running docker file
docker run -h ontpipe -ti --name ontpipe ontpipe:v1 /bin/bash

download guppy:
wget https://mirror.oxfordnanoportal.com/software/analysis/ont-guppy-cpu_3.0.3_linux64.tar.gz
tar -xf ont-guppy-cpu_3.0.3_linux64.tar.gz

download data:
created a data directory:

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1e-xYLDEEzi8UqRf30KVTymmHNxr_te7P' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1e-xYLDEEzi8UqRf30KVTymmHNxr_te7P" -O barcode01.tar.gz && rm -rf /tmp/cookies.txt


Merging data:

#!/bin/bash

for i in {0..17}; do
    (
    cd barcode01/$i || continue
    cp *.fast5 ../Combfast5
    )

done


basecalling:
./opt/ont-guppy-cpu/bin/guppy_basecaller -i /data/Combfast5/ -s guppy_out --flowcell FLO-MIN107 --kit SQK-LSK108 --c
pu_threads_per_caller 100


barcoding:
./opt/ont-guppy-cpu/bin/guppy_barcoder -i guppy_out/ -s barcoding



Preprocessing:
preprocess.py -b barcoding/barcoding_summay.txt -s guppy_out/sequencing_summary.txt -o outdir


#the filtering step failed for me so i skiped it

mkdir Run && cd Run

#everything from this point ran fine