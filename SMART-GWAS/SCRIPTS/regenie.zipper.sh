#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=zipper_regenie    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem-per-cpu=10G                    # Job memory request
#SBATCH --time=4:00:00               # Time limit hrs:min:sec
##SBATCH --output=zipper_regenie.log   # Standard output and error log


# Root loc for emma

ESMULDERS="/hpc/dhl_ec/esmulders"

# Phenotype of GWAS

PHENOTYPE="IMT"

#sex of samples

SEX0="combined"
SEX1="male"
SEX2="female"

# SMART GitHub location

REGENIE_SMART="${ESMULDERS}/REGENIE_SMART"

OUTPUT="${REGENIE_SMART}/RESULTS"

gzip -vf ${OUTPUT}/regenie.${PHENOTYPE}.summary_results.${SEX0}.txt
gzip -vf ${OUTPUT}/regenie.${PHENOTYPE}.summary_results.${SEX1}.txt
gzip -vf ${OUTPUT}/regenie.${PHENOTYPE}.summary_results.${SEX2}.txt
