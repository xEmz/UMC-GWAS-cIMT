#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=wrapper_regenie    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem-per-cpu=10G                    # Job memory request
#SBATCH --time=12:00:00               # Time limit hrs:min:sec
#SBATCH --output=wrapper_regenie.log   # Standard output and error log

# Path to where the software resides on the server.
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"

# Path to where GWASToolKit resides on the server.
GWASTOOLKITDIR="${SOFTWARE}/GWASToolKit"

# Root loc for emma

ESMULDERS="/hpc/dhl_ec/esmulders"

# SMART GitHub location

REGENIE_SMART="${ESMULDERS}/REGENIE_SMART"

# Input generated in step 2

PHENOTYPE="IMT"

#sex of samples

SEX0="combined"
SEX1="male"
SEX2="female"

INPUT_combined="${REGENIE_SMART}/OUTPUT_REGENIE/OUTPUT_STEP2_IMT_${SEX0}"
INPUT_male="${REGENIE_SMART}/OUTPUT_REGENIE/OUTPUT_STEP2_IMT_${SEX1}"
INPUT_female="${REGENIE_SMART}/OUTPUT_REGENIE/OUTPUT_STEP2_IMT_${SEX2}"

# Output directory

mkdir ${REGENIE_SMART}/RESULTS/RESULTS_IMT
OUTPUT="${REGENIE_SMART}/RESULTS/RESULTS_IMT"

echo "CHROM GENPOS ID ALLELE0 ALLELE1 A1FREQ INFO N TEST BETA SE CHISQ LOG10P EXTRA" > ${OUTPUT}/regenie.summary_results.${SEX0}.txt
#echo "CHROM GENPOS ID ALLELE0 ALLELE1 A1FREQ INFO N TEST BETA SE CHISQ LOG10P EXTRA" > ${OUTPUT}/#regenie.summary_results.${SEX1}.txt
#echo "CHROM GENPOS ID ALLELE0 ALLELE1 A1FREQ INFO N TEST BETA SE CHISQ LOG10P EXTRA" > ${OUTPUT}/#regenie.summary_results.${SEX2}.txt

# Create a wrapper loop which outputs all the output files into one file

for CHR in $(seq 1 23); do
cat ${INPUT_combined}/chr_${CHR}_${SEX0}_${PHENOTYPE}.regenie | grep -v "#" | ${GWASTOOLKITDIR}/SCRIPTS/parseTable.pl --col CHROM,GENPOS,ID,ALLELE0,ALLELE1,A1FREQ,INFO,N,TEST,BETA,SE,CHISQ,LOG10P,EXTRA |tail -n +2 | awk ' { print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14} ' >> ${OUTPUT}/regenie.summary_results.${SEX0}.txt

cat ${INPUT_male}/chr_${CHR}_${SEX1}_${PHENOTYPE}.regenie | grep -v "#" | ${GWASTOOLKITDIR}/SCRIPTS/parseTable.pl --col CHROM,GENPOS,ID,ALLELE0,ALLELE1,A1FREQ,INFO,N,TEST,BETA,SE,CHISQ,LOG10P,EXTRA |tail -n +2 | awk ' { print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14} ' >> ${OUTPUT}/regenie.summary_results.${SEX1}.txt

cat ${INPUT_female}/chr_${CHR}_${SEX2}_${PHENOTYPE}.regenie | grep -v "#" | ${GWASTOOLKITDIR}/SCRIPTS/parseTable.pl --col CHROM,GENPOS,ID,ALLELE0,ALLELE1,A1FREQ,INFO,N,TEST,BETA,SE,CHISQ,LOG10P,EXTRA |tail -n +2 | awk ' { print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13, $14} ' >> ${OUTPUT}/regenie.summary_results.${SEX2}.txt
		done
