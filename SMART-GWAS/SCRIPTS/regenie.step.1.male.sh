#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=step1_regenie_male    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem=10G                    # Job memory request
#SBATCH --time=12:00:00               # Time limit hrs:min:sec
#SBATCH --output=regenie_step1_male.log   # Standard output and error log
#SBATCH --array=1-23                # create 23 jobs for every chromosome



#Path to where the software resides on the server.
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"

#Path to where REGENIE resides on the server.
REGENIE="${SOFTWARE}/regenie_v3.1.3.gz_x86_64_Centos7_mkl"

#Root location for Emma

ESMULDERS="/hpc/dhl_ec/esmulders"

#SMART GitHub location

REGENIE_SMART="${ESMULDERS}/REGENIE_SMART"

#SNP location for phenotypes, covariates and samples to keep

SNP="${REGENIE_SMART}/SNP"

# List of .bgen input files

BGEN="${REGENIE_SMART}/BGEN_input_filtered/chr_$SLURM_ARRAY_TASK_ID.8bit.bgen"

# Path to sample file
SAMPLE="${REGENIE_SMART}/BGEN_input_filtered/chr_$SLURM_ARRAY_TASK_ID.8bit.sample"

# sex of samples

SEX="male"

NA="${SNP}/no_NA.SMARTbaseline_IMT_WHO.${SEX}.txt"

# phenotype path file

PHENOTYPES="${SNP}/phenotypes.txt" 

# covariates path file

COVARIATES="${SNP}/sex.covariates.txt" 

#output directory

mkdir ${REGENIE_SMART}/OUTPUT_REGENIE/OUTPUT_STEP1_IMT_${SEX}
OUTPUT="${REGENIE_SMART}/OUTPUT_REGENIE/OUTPUT_STEP1_IMT_${SEX}/chr_${SLURM_ARRAY_TASK_ID}_${SEX}"


# Step 1 : create LOCO predictions

regenie_step_1 () {
${REGENIE} \
 --step 1 \
 --bgen ${BGEN} \
 --sample ${SAMPLE} --keep ${NA} \
 --covarFile ${COVARIATES} --sex-specific ${SEX} \
 --phenoFile ${PHENOTYPES} --apply-rint \
 --bsize 1000 \
 --qt \
 --gz \
 --out ${OUTPUT}
}

# run function

regenie_step_1 "${BGEN[$SLURM_ARRAY_TASK_ID-1]}"
