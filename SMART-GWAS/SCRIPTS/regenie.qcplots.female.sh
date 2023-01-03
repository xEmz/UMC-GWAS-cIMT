#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=qc.plotter_regenie.female    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem-per-cpu=10G                    # Job memory request
#SBATCH --time=10:00:00               # Time limit hrs:min:sec
#SBATCH --output=qc.plotter_regenie_female.log   # Standard output and error log



#Path to where the software resides on the server.
SOFTWARE="/hpc/local/CentOS7/dhl_ec/software"

# REQUIRED: Path_to where GWASToolKit resides on the server.
GWASTOOLKITDIR="${SOFTWARE}/GWASToolKit"

SCRIPTS="${GWASTOOLKITDIR}/SCRIPTS"

#Root location for Emma

ESMULDERS="/hpc/dhl_ec/esmulders"

#Project directory

PROJECTDIR="${ESMULDERS}/REGENIE_SMART"

### SET INPUT-DATA

PHENOTYPE="IMT"	

SEX="female"

mkdir ${PROJECTDIR}/RESULTS/RESULTS_IMT/plots/${SEX}
OUTPUT="${PROJECTDIR}/RESULTS/RESULTS_IMT/plots/${SEX}"

# what is the basename of the file?
RESULTS="${PROJECTDIR}/RESULTS/RESULTS_IMT/regenie.${PHENOTYPE}.summary_results.${SEX}.QC"

FILENAME="REGENIE.${PHENOTYPE}.${SEX}.Results.QC"


### COLUMN NAMES & NUMBERS
	###     1    2   3  4            5            6              7    8      9     10     11     12  13  14  15
	### CHR	POS	ID	ALLELE0	ALLELE1	A1FREQ	INFO	N	TEST	BETA	SE	CHISQ	LOG10P	EXTRA	P
		


	#### QQ-plot including 95%CI and compute lambda [P]
	echo "Making QQ-plot including 95%CI and compute lambda..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col P | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.QC.QQplot.txt
		Rscript ${SCRIPTS}/plotter.qq.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.QC.QQplot.txt -o ${OUTPUT} -s PVAL -f PNG
	echo ""

	### Manhattan plot for publications [CHR, BP, P]
	echo "Manhattan plot for publications ..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col CHROM,GENPOS,P | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.QC.Manhattan.txt
		Rscript ${SCRIPTS}/plotter.manhattan.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.QC.Manhattan.txt -o ${OUTPUT} -c FULL -f PNG -t ${FILENAME}
		Rscript ${SCRIPTS}/plotter.manhattan.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.QC.Manhattan.txt -o ${OUTPUT} -c TWOCOLOR -f PNG -t ${FILENAME}

	echo "Finished plotting, zipping up and re-organising intermediate files!"
	#rm -v ${OUTPUT}/${PHENOTYPE}.QQplot.txt
	#rm -v ${OUTPUT}/${PHENOTYPE}.Manhattan.txt
	echo ""
f