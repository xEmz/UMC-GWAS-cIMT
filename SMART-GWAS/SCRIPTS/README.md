# Scripts
<p>
Outside of regenie, this kit makes use of PLINK2, BGENIX, QCTOOL, and perl and R scripts.
 </p>
<br>
<br>
<p><b><i>Current bash (.sh) scripts:</i></b>

[SMART.make.bgen](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/SMART.make.bgen.sh):
- Convert individual autosomal chromosome .gen files to .bgen and .sample using PLINK2. [Filtered](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/SMART.make.bgen.filtered.sh) script is used for regenie <b>step 1</b>, [unfiltered](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/SMART.make.bgen.sh) script used for regenie <b>step 2</b>.

[qctool.chromosome.X](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/qctool.chromosome.X.sh):
- Converts .gen.gz file of chromosome 23 to .gen.gz file with males coded as diploid. Output file used for .bgen format conversion.

[SMART.make.bgen.X](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/SMART.make.bgen.X.sh):
- Convert X chromosome .gen file to .bgen and .sample file. Seperate .sample file is used with males coded as diploid. [Filtered](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/SMART.make.bgen.filtered.X.sh) script is used for regenie <b>step 1</b>, [unfiltered](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/SMART.make.bgen.X.sh) script used for regenie <b>step 2</b>.

[bgi.generate](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/bgi.generate.sh):
- Generates index files from the .bgen files. Used by REGENIE to quicken the process.

[regenie.step.1](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.step.1.combined.sh):
- Run step 1 from regenie on each chromosome .bgen file with specified covariates and phenotypes to create LOCO predictions. Seperate scripts for [combined](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.step.1.combined.sh) and [male](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.step.1.male.sh)/[female](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.step.1.female.sh) stratified analysis.

[regenie.step.2](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.step.2.combined.sh):
- Run step 2 from regenie on each chromosome .bgen file with specified covariates and phenotypes using generated LOCO predictions to analyse associations. Seperate scripts from [combined](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.step.2.combined.sh) and [male](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.step.2.male.sh)/[female](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.step.2.female.sh) analysis.

[regenie.wrapper](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.wrapper.sh):
- Wraps up results of each chromosome into one file (uses perl script).

[regenie.zipper](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.zipper.sh):
- Zips up file as .gz.

[regenie.qc](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.qc.sh):
- Filters out SNPs with set BETA, Z-score, P-value and MAF quality. Seperate scripts for [combined](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.qc.combined.sh) and [male](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.qc.male.sh)/[female](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.qc.female.sh) stratified analysis.

[regenie.plotter](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/regenie.plotter.sh):
- Plots out results using R scripts in:
<br>-- QQ
<br>-- ManHattan
<br>-- P-Z
<br> 
Seperate scripts for [combined](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.plotter.combined.sh) and [male](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.plotter.male.sh)/[female](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.plotter.female.sh) stratified analysis.
<br>
<br> 
 Plots from filtered files are generated with qcplots. Seperate scripts for [combined](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.qcplots.combined.sh) and [male](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.qcplots.male.sh)/[female](https://github.com/xEmz/UMC-GWAS-cIMT/blob/e4906bfa9f77ea09f1c18e0b2c5f4af2fd0bc2f7/SMART-GWAS/SCRIPTS/regenie.qcplots.female.sh) stratified analysis. 
 </br>
 </p>
<p><b><i>Current R scripts:</i></b>
 <br>
[Generate.P.R](https://github.com/xEmz/UMC-GWAS-cIMT/blob/6b4ee734e805da62edce6fdbc66dc152bd365b64/SMART-GWAS/SCRIPTS/Generate.P.R):
 - Calculate P-values from -log10P REGENIE output 
 </p>
