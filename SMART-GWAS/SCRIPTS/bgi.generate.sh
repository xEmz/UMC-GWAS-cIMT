#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=bgen_index    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=10G                    # Job memory request
#SBATCH --time=4:00:00               # Time limit hrs:min:sec
#SBATCH --output=bgen_index.log   # Standard output and error log
#SBATCH --array=1-23                # create 23 jobs from this



#Path to where the software resides on the server.
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"


#Path to where PLINK2 resides on the server.
bgenix="${SOFTWARE}/bgenix"

#Root location for emma

ESMULDERS="/hpc/dhl_ec/esmulders"

#SMART github location

REGENIE_SMART="${ESMULDERS}/REGENIE_SMART"

BGEN="${REGENIE_SMART}/BGEN_input/chr_$SLURM_ARRAY_TASK_ID.8bit.bgen"

bgi_generate () {
${bgenix} -index -g ${BGEN}
}

bgi_generate "${BGEN[$SLURM_ARRAY_TASK_ID-1]}"

