#!/usr/bin/env bash


# SLURM settings
#SBATCH --job-name=plotter_regenie_combined    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem-per-cpu=10G                    # Job memory request
#SBATCH --time=10:00:00               # Time limit hrs:min:sec
#SBATCH --output=plotter_regenie_combined.log   # Standard output and error log


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

SEX="combined"

PHENOTYPE="IMT"	

mkdir ${PROJECTDIR}/RESULTS/RESULTS_IMT/plots/${SEX}
OUTPUT="${PROJECTDIR}/RESULTS/RESULTS_IMT/plots/${SEX}"

# what is the basename of the file?
RESULTS="${PROJECTDIR}/RESULTS/RESULTS_IMT/regenie.${PHENOTYPE}.summary_results.${SEX}"

FILENAME="REGENIE.${PHENOTYPE}.${SEX}.Results"
	
	
	### COLUMN NAMES & NUMBERS
	###     1    2   3  4            5            6              7    8      9     10     11     12  13  14  15
	### CHR	POS	ID	ALLELE0	ALLELE1	A1FREQ	INFO	N	TEST	BETA	SE	CHISQ	LOG10P	EXTRA	P
	
### QQ-plot including 95%CI and compute lambda [P]
	echo "Making QQ-plot including 95%CI and compute lambda..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col P | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.QQplot_CI.txt
		Rscript ${SCRIPTS}/plotter.qq.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.QQplot_CI.txt -o ${OUTPUT} -s PVAL -f PNG
	echo ""

	
	### QQ-plot stratified by effect allele frequency [P, EAF]
	echo "QQ-plot stratified by effect allele frequency..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col P,A1FREQ | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.QQplot_EAF.txt
		Rscript ${SCRIPTS}/plotter.qq_by_caf.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.QQplot_EAF.txt -o ${OUTPUT} -s PVAL -f PNG
	echo ""
	
	## QQ-plot stratified by imputation quality (info -- imputation quality) [P, INFO]
	echo "QQ-plot stratified by imputation quality..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col P,INFO | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.QQplot_INFO.txt
		Rscript ${SCRIPTS}/plotter.qq_by_info.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.QQplot_INFO.txt -o ${OUTPUT} -s PVAL -f PNG
	echo ""
	
	### Plot the imputation quality (info) in a histogram [INFO]
	echo "Plot the imputation quality (info) in a histogram..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col INFO | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.Histogram_INFO.txt 
		Rscript ${SCRIPTS}/plotter.infoscore.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.Histogram_INFO.txt -o ${OUTPUT} -f PNG
	echo ""
	
	### Plot the BETAs in a histogram [BETA]
	echo "Plot the BETAs in a histogram..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col BETA | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.Histogram_BETA.txt 
		Rscript ${SCRIPTS}/plotter.effectsize.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.Histogram_BETA.txt -o ${OUTPUT} -f PNG
	echo ""
	
	### Plot the Z-score based p-value (calculated from beta/se) and P [BETA, SE, P]
	echo "Plot the Z-score based p-value (calculated from beta/se) and P..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col BETA,SE,P | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.PZ_Plot.txt 
		Rscript ${SCRIPTS}/plotter.p_z.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.PZ_Plot.txt -o ${OUTPUT} -s 500000 -f PNG
	echo ""
	
	### Manhattan plot for quick inspection (trunzcated upto -log10(p-value)) [CHR, BP, P]
	echo "Manhattan plot for quick inspection (trunzcated upto -log10(p-value)=2)..."
	zcat ${RESULTS}.txt.gz | ${SCRIPTS}/parseTable.pl --col CHROM,GENPOS,P | tail -n +2 | grep -v NA > ${OUTPUT}/${PHENOTYPE}.${SEX}.Manhattan_forQuickInspect.txt
		Rscript ${SCRIPTS}/plotter.manhattan.R -p ${OUTPUT} -r ${OUTPUT}/${PHENOTYPE}.${SEX}.Manhattan_forQuickInspect.txt -o ${OUTPUT} -c QC -f PNG -t ${FILENAME}
	echo ""