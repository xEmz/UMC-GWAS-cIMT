#!/usr/bin/env bash
# SLURM settings
#SBATCH --job-name=chromosome_23_qctool    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=10G                    # Job memory request
#SBATCH --time=4:00:00               # Time limit hrs:min:sec
#SBATCH --output=chromosome_23_qctool.log   # Standard output and error log

### run QCTOOL with variant file, if it does not work with rsid file

#Path to where the software resides on the server.
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"

#Path to where QCTOOL resides on the server.
QCTOOL="${SOFTWARE}/qctool_v208"

#Root location for Emma
ESMULDERS="/hpc/dhl_ec/esmulders"

#SMART github location
REGENIE_SMART="${ESMULDERS}/REGENIE_SMART"

SNP="${REGENIE_SMART}/SNP"

#Path to where SMART genetic data resides
SMART_DATA="/hpc/dhl_ec/data/SMART"

#ARRAY - Path to genetic data of individual chromosomes
chromosome_23="${SMART_DATA}/SMART_chr23.gen.gz"

#Path to sample file
SAMPLE="${SNP}/20221102.SMARTbaseline_IMT_WHO.SMARTGS.diploid.sample"

mkdir ${REGENIE_SMART}/chr_23
OUTPUT="${REGENIE_SMART}/chr_23/SMART_chr23.gen.gz"

${QCTOOL} -g ${chromosome_23} -s ${SAMPLE} -infer-ploidy-from sex -og ${OUTPUT}


