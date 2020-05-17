### Bash Awk solution to renaming fastq file.  

cat M3NLS_1.m6A.fastq | awk '{print (NR%4 == 1) ? "@M3NLS_1_m6A_ACTB_" ++i : $0}' > renamed/M3NLS_1.m6A.fastq
