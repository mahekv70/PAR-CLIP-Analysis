#!/bin/bash
#PBS -N INPUT_NAME
#PBS -l select=1:ncpus=4:mem=32gb
#PBS -e err.INPUT_NAME.txt
#PBS -o out.INPUT_NAME.txt

cd $PBS_O_WORKDIR
cd /lcrb/Mahek/C8orf82/kmer


module load cutadapt
module load perl/perl-5.30.1


/lcrb/Mahek/C8orf82/kmer/Clipmahek.sh /lcrb/Mahek/C8orf82/kmer/ngenes.bed /lcrb/Homo_sapiens_UCSC_hg38/Sequence/WholeGenomeFasta/genome.fa 4

##run as qsub -q power-benhalevy kmer.sh
