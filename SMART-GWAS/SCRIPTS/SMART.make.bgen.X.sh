#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=plink2_make_bgen_X    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=10G                    # Job memory request
#SBATCH --time=4:00:00               # Time limit hrs:min:sec
#SBATCH --output=plink2_make_bgen_X.log   # Standard output and error log
##SBATCH --array=1-23                # create 23 jobs from this



#Path to where the software resides on the server.
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"

#Path to where REGENIE resides on the server.
REGENIE="${SOFTWARE}/regenie_v3.1.3.gz_x86_64_Centos7_mkl"

#Path to where PLINK2 resides on the server.
PLINK2="${SOFTWARE}/plink2alpha_v3.6_2022aug14"

#Root location for emma

ESMULDERS="/hpc/dhl_ec/esmulders"

#SMART github location

REGENIE_SMART="${ESMULDERS}/REGENIE_SMART"

SNP="${REGENIE_SMART}/SNP"

# chromosome 23 data
chromosome_23="${REGENIE_SMART}/chr_23/SMART_chr23.gen.gz"

#Path to sample file
SAMPLE="${SNP}/20221102.SMARTbaseline_IMT_WHO.SMARTGS.diploid.sample"

#samples to keep

without_NA="${SNP}/no_NA.SMARTbaseline_IMT_WHO.txt"

#Path to where the PLINK2 output needs to go (see function for further specifics)

mkdir ${REGENIE_SMART}/BGEN_input
OUTPUT="${REGENIE_SMART}/BGEN_input/chr_23.8bit"

#Create function to convert .gen and .sample files to .bgen files for each chromosome with set quality parameters


bgen_generate () {
${PLINK2} --gen ${chromosome_23} ref-first --sample ${SAMPLE} --keep ${without_NA} --export bgen-1.2 'bits=8' --out ${OUTPUT}
}

#Run function

bgen_generate
