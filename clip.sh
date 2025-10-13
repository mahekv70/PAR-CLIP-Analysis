###mera_v1.1.5####

if [[ $# -eq 0 ]] ; then
    echo 'mera v1.1.5
    No input files provided
Please type "--help" for instructions'
    exit 0
fi

{
if [ $1 == "--help" ] || [ $1 == "-h" ]
    then
    echo "
    					### MERA v1.1.5###

    	Mera is a program to count k-mers score = norm #KmerX BOUND / norm #KmerX INPUT
    					######################
    	####################################################################################################

    	usage: sh clip_kmerenrch.sh clusters.bed genome.fa kmer
        ####################################################################################################"


        		exit 0
fi
}

##module load bedtools2
module load cutadapt
bedfile=$1
genome_fasta=$2
len=$3

# Define bedfile_basename
bedfile_basename=$(basename $bedfile)

awk -F "\t" '{OFS="\t"; print $1,$2-20,$3+20,$4,$5,$6}' ${bedfile} | awk '$2 > 0' > bound_${bedfile_basename}
awk -F "\t" '{OFS="\t"; print $1,$2-220,$3-180,$4,$5,$6}'  ${bedfile} | awk '$2 > 0'  > input_${bedfile_basename}

bedtools getfasta -s -fi $genome_fasta -bed bound_${bedfile_basename} -fo bound_${bedfile_basename}.fasta
bedtools getfasta -s -fi $genome_fasta -bed input_${bedfile_basename} -fo input_${bedfile_basename}.fasta

#create all combinations of mers
{
if [[ $len -eq 3 ]] ; then
perl -le '@c = ("A","T","C","G"); for $a (@c){for $b(@c){for $c(@c){print "$a$b$c"}}}' > ${bedfile_basename}mers.txt
elif [[ $len -eq 4 ]] ; then
perl -le '@c = ("A","T","C","G"); for $a (@c){for $b(@c){for $c(@c){for $d(@c){print "$a$b$c$d"}}}}' > ${bedfile_basename}mers.txt
elif [[ $len -eq 5 ]] ; then
perl -le '@c = ("A","T","C","G"); for $a (@c){for $b(@c){for $c(@c){for $d(@c){for $e(@c){print "$a$b$c$d$e"}}}}}' > ${bedfile_basename}mers.txt
elif [[ $len -eq 6 ]] ; then
perl -le '@c = ("A","T","C","G"); for $a (@c){for $b(@c){for $c(@c){for $d(@c){for $e(@c){for $f(@c){print "$a$b$c$d$e$f"}}}}}}' > ${bedfile_basename}mers.txt
elif [[ $len -eq 7 ]] ; then
perl -le '@c = ("A","T","C","G"); for $a (@c){for $b(@c){for $c(@c){for $d(@c){for $e(@c){for $f(@c){for $g(@c){print "$a$b$c$d$e$f$g"}}}}}}}' > ${bedfile_basename}mers.txt
elif [[ $len -eq 8 ]] ; then
perl -le '@c = ("A","T","C","G"); for $a (@c){for $b(@c){for $c(@c){for $d(@c){for $e(@c){for $f(@c){for $g(@c){for $h(@c){print "$a$b$c$d$e$f$g$h"}}}}}}}}' > ${bedfile_basename}mers.txt
elif [[ $len -eq 9 ]] ; then
perl -le '@c = ("A","T","C","G"); for $a (@c){for $b(@c){for $c(@c){for $d(@c){for $e(@c){for $f(@c){for $g(@c){for $h(@c){for $i(@c){print "$a$b$c$d$e$f$g$h$i"}}}}}}}}}' > ${bedfile_basename}mers.txt
elif [[ $len -eq 0 ]] ; then
echo "provide k-mer length"
exit 0
fi
}

#count each mer in the fasta files

grep -v ">" input_${bedfile_basename}.fasta | grep -v "@" > filt_input_${bedfile_basename}.fasta

grep -v ">" bound_${bedfile_basename}.fasta | grep -v "@" > filt_bound_${bedfile_basename}.fasta


input1_reads=$(sed -n '$=' filt_input_${bedfile_basename}.fasta)
bound1_reads=$(sed -n '$=' filt_bound_${bedfile_basename}.fasta)


parallel 'echo {1} ; grep -i -o {1} {2} | wc -l' :::: ${bedfile_basename}mers.txt ::: filt_input_${bedfile_basename}.fasta | paste - - | sort > input_${bedfile_basename}${len}mers_out1.txt
wait
parallel 'echo {1} ; grep -i -o {1} {2} | wc -l' :::: ${bedfile_basename}mers.txt ::: filt_bound_${bedfile_basename}.fasta | paste - - | sort > bound_${bedfile_basename}${len}mers_out1.txt
wait


rm filt_input_${bedfile_basename}.fasta
rm filt_bound_${bedfile_basename}.fasta


paste input_${bedfile_basename}${len}mers_out1.txt bound_${bedfile_basename}${len}mers_out1.txt | sed 's/\s/\t/g' > ${bedfile_basename}_${len}mers_out2.txt

rm input_${bedfile_basename}${len}mers_out1.txt
rm bound_${bedfile_basename}${len}mers_out1.txt