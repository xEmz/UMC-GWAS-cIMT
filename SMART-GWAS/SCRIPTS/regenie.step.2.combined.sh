#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=step2_regenie    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem-per-cpu=10G                    # Job memory request
#SBATCH --time=12:00:00               # Time limit hrs:min:sec
#SBATCH --output=regenie_step2.log   # Standard output and error log
#SBATCH --array=1-23                # create 23 jobs for every chromosome



# Path to where the software resides on the server.
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"

# Path to where REGENIE resides on the server.
REGENIE="${SOFTWARE}/regenie_v3.1.3.gz_x86_64_Centos7_mkl"

# Path to where PLINK2 resides on the server.
PLINK2="${SOFTWARE}/plink2alpha_v3.6_2022aug14"

# root loc for emma

ESMULDERS="/hpc/dhl_ec/esmulders"

# SMART GitHub location

REGENIE_SMART="${ESMULDERS}/REGENIE_SMART"

# SNP loc

SNP="${REGENIE_SMART}/SNP"

SMART_DATA="/hpc/dhl_ec/data/SMART"

# List of .bgen input files

BGEN="${REGENIE_SMART}/BGEN_input/chr_$SLURM_ARRAY_TASK_ID.8bit.bgen"

# Path to sample file
SAMPLE="${REGENIE_SMART}/BGEN_input/chr_$SLURM_ARRAY_TASK_ID.8bit.sample"

# sex of samples

SEX="combined"

# phenotype path file

PHENOTYPES="${SNP}/phenotypes.txt" 

# covariates path file

COVARIATES="${SNP}/covariates.txt" 

# input generated in step 1

INPUT="${REGENIE_SMART}/OUTPUT_REGENIE/OUTPUT_STEP1_IMT_${SEX}/chr_${SLURM_ARRAY_TASK_ID}_${SEX}_pred.list"

#output directory

mkdir ${REGENIE_SMART}/OUTPUT_REGENIE/OUTPUT_STEP2_IMT_${SEX}
OUTPUT="${REGENIE_SMART}/OUTPUT_REGENIE/OUTPUT_STEP2_IMT_${SEX}/chr_${SLURM_ARRAY_TASK_ID}_${SEX}"

# Step 2: Run GWAS
  
regenie_step_2 () {
${REGENIE} \
 --step 2 \
 --bgen ${BGEN} \
 --sample ${SAMPLE} \
 --covarFile ${COVARIATES} \
 --phenoFile ${PHENOTYPES} --apply-rint \
 --bsize 400 \
 --qt \
 --approx \
 --pThresh 0.05 \
 --minINFO 0.40 \
 --pred ${INPUT} \
 --out ${OUTPUT}
}

# run function

regenie_step_2 "${BGEN[$SLURM_ARRAY_TASK_ID-1]}"

