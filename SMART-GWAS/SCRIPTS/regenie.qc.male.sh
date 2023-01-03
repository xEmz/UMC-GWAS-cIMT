#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=regenie_qc_male    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem-per-cpu=10G                    # Job memory request
#SBATCH --time=10:00:00               # Time limit hrs:min:sec
#SBATCH --output=regenie_qc_male.log   # Standard output and error log


# Root loc for emma

ESMULDERS="/hpc/dhl_ec/esmulders"

#Project directory

PROJECTDIR="${ESMULDERS}/REGENIE_SMART"

### SET INPUT-DATA

PHENOTYPE="IMT"	

SEX="male"

OUTPUT="${PROJECTDIR}/RESULTS"

# what is the basename of the file?
RESULTS="regenie.${PHENOTYPE}.summary_results.${SEX}"

# REQUIRED: Filter settings -- specifically, GWAS, GENE and REGIONAL analyses
INFO="0.4"
#MAC="6"
CAF="0.005"
BETA_SE="100"

	### COLUMN NAMES & NUMBERS
	### 1    2	3	4	5	6	7	8	9	10	11	12	13	14	15
	### CHR	POS	ID	ALLELE0	ALLELE1	A1FREQ	INFO	N	TEST	BETA	SE	CHISQ	LOG10P	EXTRA	P

	echo ""
	echo "Filtering data, using the following criteria: "
	echo "  * ${INFO} <= INFO < 1 " #done with regenie
	echo "  * CAF > ${CAF} "
	echo "  * MAC >= ${MAC} "
	echo "  * BETA/SE/P != NA "
	echo "  * -${BETA_SE} <= BETA/SE < ${BETA_SE}. "
	zcat ${OUTPUT}/${RESULTS}.txt.gz | head -1 > ${OUTPUT}/${RESULTS}.QC.txt


	zcat ${OUTPUT}/${RESULTS}.txt.gz | awk '( $6 >= '${CAF}' && $15 != "NA" && $15 <= 1 && $15 >= 0 && $10 != "NA" && $10 < '${BETA_SE}' && $10 > -'${BETA_SE}' && $11 != "NA" && $11 < '${BETA_SE}' && $11 > -'${BETA_SE}' )' >> ${OUTPUT}/${RESULTS}.QC.txt
	echo "Number of QC'd variants:"
	cat ${OUTPUT}/${RESULTS}.QC.txt | wc -l
	echo "Head of QC'd file:"
	head ${OUTPUT}/${RESULTS}.QC.txt
	echo ""
	echo "Tail of QC'd file:"
	tail ${OUTPUT}/${RESULTS}.QC.txt
	echo ""
	echo ""
	echo "Zipping up..."
	gzip -fv ${OUTPUT}/${RESULTS}.QC.txt
	echo ""
	echo ""
