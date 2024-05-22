#!/bin/bash

#SBATCH --job-name SVDQbootstrap
#SBATCH -A tanklab
#SBATCH -t 0-24:00:00
#SBATCH --nodes=1
#SBATCH --cpus-per-task=24   
#SBATCH --mem=36G
#SBATCH --mail-type=ALL
#SBATCH --mail-user=cbrose1@uwyo.edu
#SBATCH -e err_svdqboot_%A_%a.err
#SBATCH -o std_svdqboot_%A_%a.out

#change working directory to where your output files will go
cd /project/tanklab/cbrose1/cusickii/SVDQ

module load paup

#define slurm variables for the PAUPblock
filebname="cusickii_8apr24" #basename for all produced files
infile="cusickii_rmFailed.nex" #name of input nexus file; can give a path so the input files don't have to be part of the working directory
nthreads=$SLURM_CPUS_PER_TASK #number of threads in the slurm script
nreps=200 #number of reps for bootstrapping

cat <<EOF > $filebname.paup.txt
Begin paup;
set autoclose=yes warntree=no warnreset=no flock=no;
log start file=$filebname.log ;
execute $infile;
svdQuartets evalQuartets=all showScores=no ambigs=distribute bootstrap=no nthreads=$nthreads;
savetrees file=$filebname.besttree.tre;
svdQuartets evalQuartets=all showScores=no ambigs=distribute bootstrap=standard nreps=$nreps nthreads=$nthreads treefile=$filebname.svdqboots.tre;  
quit; 
end;
EOF

paup $filebname.paup.txt #execute your new paup block file

module load  gcc/12.2.0 r/4.2.2 #open R 
Rscript ../SlurmScripts/bootanno.R $filebname.besttree.tre $filebname.svdqboots.tre #run R script with the best tree and bootstrap values 
