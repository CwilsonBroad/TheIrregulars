#Converts bams to pair-end reads. 

#!/bin/bash
#SBATCH -N 1
#SBATCH -n 2
#SBATCH --mem 10000
#SBATCH -p shared
#SBATCH -o wgetGenome_%A.out
#SBATCH -e wgetGenome_%A.err
#SBATCH -J wgetGenome_chupa
#SBATCH -t 10:00:00

module load bedtools2
module load samtools

Names=*.bam

for name in $Names; do
samtools sort -n $name -o $name.qsort
done

Names=*.qsort

for name in $Names; do
bedtools bamtofastq -i $name \
                      -fq $name.R1.fq \
                      -fq2 $name.R2.fq
done
echo "All done asshole"
