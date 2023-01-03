# Scripts
<p>
Outside of REGENIE, this kit makes use of PLINK2, BGENIX, QCTOOL, and perl and R scripts.
 </p>
<br>
<br>
<p><b><i>Current bash (.sh) scripts:</i></b>

[SMART.make.bgen.filtered](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/SMART.make.bgen.filtered.sh):
- Convert individual autosomal chromosome .gen files to .bgen and .sample using PLINK2. Output files used for REGENIE <b>step 1</b>.

[SMART.make.bgen](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/SMART.make.bgen.sh):
- Convert individual autosomal chromosome .gen files to .bgen and .sample using PLINK2. Output files used for REGENIE <b>step 2</b>.

qctool.chromosome.X:
- Converts .gen.gz file of chromosome 23 to .gen.gz file with males coded as diploid. Output file used for .bgen format conversion.

SMART.make.bgen(.filtered).X:
- Convert X chromosome .gen file to .bgen and .sample file. Seperate .sample file is used with males coded as diploid. Output files used for REGENIE.

bgi.generate:
- Generates index files from the .bgen files. Used by REGENIE to quicken the process.

regenie.step.1:
- Run step 1 from regenie on each chromosome .bgen file with specified covariates and phenotypes to create LOCO predictions. Seperate scripts from <b>combined</b> and <b>male/female stratified</b> analysis.

regenie.step.2:
- Run step 2 from regenie on each chromosome .bgen file with specified covariates and phenotypes using generated LOCO predictions to analyse associations. Seperate scripts from <b>combined and male/female stratified</b> analysis.

regenie.wrapper:
- Wraps up results of each chromosome into one file (uses perl script).

regenie.zipper:
- Zips up file as .gz.

regenie.qc:
- Filters out SNPs with set BETA, Z-score, P-value and MAF quality

regenie.plotter:
- Plots out results using R scripts in:
<br>-- QQ
<br>-- ManHattan
<br>-- P-Z
<br>
 </p>
<p><b><i>Current R scripts:</i></b>

Generate.P:
 - Calculate P-values from -log10P REGENIE output 
 </p>
