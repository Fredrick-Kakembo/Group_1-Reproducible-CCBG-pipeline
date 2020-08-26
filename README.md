# Group:1-Reproducible-CCBG-pipeline

This is a group 1 mini-project about **Reproducing a published workflow for bacterial genome**

# We are required to :
- Collaborative on the project using git hub 
- Learn from each other and carry out tasks in the event we are assigned any
- By the end of the project submit a reproducible workflow e.g. in Snakeamke
- Observe proper script documentation, should be informative
- Use visualizations
- Write a report about the mini project

# Specifically to our mini project we are required to:
1. Download the sequence data programmatically using an API
2. The project uses CCBGpipe implemented in Python is available and packaged in Docker for reproducibility. 
   Our first task is to reproduce the analysis as in  the documented study README
3. Reproduce the analysis workflow used for genome assembly of Oxford Nanopore MinION using Nextflow or Snakemake, and Singularity for containerization.
   Remember as a group we settled on Snamake workflow
   
  # Tasks
  # Task1: Reproduce the analysis using the workflow given in the README file in CCBG_Study directory our repo
  # Task2: Reproduce the analysis using Snakemake workflow language 

# Question
In our report, we should address the following question:

1. Are we able to arrive at similar conclusions as those in the paper? Why or why not?
2. What else can we glean from your re-analysis?
3. Are the descriptions in the methodology section detailed for reproducibility? If not, what could we have done to improve reproducibility?

# Data availability:
Since the data for the 12 barcodes is too large. For reproducibility, [here is the link for barcode01](https://drive.google.com/uc?export=download&confirm=TxIT&id=1e-xYLDEEzi8UqRf30KVTymmHNxr_te7P)

# Task 1 implementation
## CCBG pipeline
This was meant to reproduce the CCBGpipe workflow as done by the authors.
### Building a docker image
To make our own copy of the CCBG pipeline we clone the CCBGpipe repo as given by the authors:

``git clone https://github.com/jade-nhri/CCBGpipe.git``

``cd CCBGpipe``

Using the given docker file we built docker image for reproduction of the analysis

``docker build -t "ccbgpipe:v1" ./``

``docker run -h ccbgpipe --name ccbgpipe -t -i -v /:/MyData ccbgpipe:v1 /bin/bash``

   Inside the docker: root@ccbgpipe:/# 
    To install java:
        apt-get update
        apt-get install -y software-properties-common
        add-apt-repository ppa:webupd8team/java
        apt-get update && apt-get install oracle-java8-installer

    Please note: the Oracle JDK license has changed starting April 16, 2019.
    You can download zulu to include Java (https://www.azul.com/downloads/zulu/).
        apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0xB1998361219BD9C9
        apt-add-repository 'deb http://repos.azulsystems.com/ubuntu stable main'
        echo 'deb http://repos.azulsystems.com/debian stable main' > /etc/apt/sources.list.d/zulu.list
        apt-get update
        apt-get install zulu-8
        
### Usage
#### Basecalling with Guppy instead of Albacore

- Installation of Albacore failed we therefore opted to basecall with Guppy

- To extract fastq files using guppy_bascaller

``guppy_basecaller -i path-to-raw_reads -s outpath (e.g., guppy_basecaller -i Fast5 -s guppy_out)``

- To de-multiplex

``guppy_barcoder -i inpath -s outpath (e.g., guppy_barcoder -i guppy_out -s barcoding)``

- To produce read_id list and joinedreads.fastq for each barcode

``preprocess.py -b path-to-barcoding_summary.txt -s path-to-sequencing_summary.txt -o outpath (e.g., preprocess.py -b barcoding/barcoding_summay.txt -s guppy_out/sequencing_summary.txt -o outdir)``

- With the data produced by the above process, you can perform CCBGpipe by beginning with creating a Run folder

``mkdir Run && cd Run``

``runGetFastq.py path-to-fast5 (e.g., runGetFastq.py ../outdir/)``

``runmini.py``

``runAssembly.py``

``runConsensus.py path-to-fast5 (e.g., runConsensus.py ../fast5/)``

``finalize.py outpath (e.g., finalize.py ../results)``






