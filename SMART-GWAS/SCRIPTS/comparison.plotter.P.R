#!/hpc/local/CentOS7/dhl_ec/software/R-3.6.3/bin/Rscript 

# SLURM settings
#SBATCH --job-name=comparison_plotter    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem-per-cpu=20G                    # Job memory request
#SBATCH --time=12:00:00               # Time limit hrs:min:sec
#SBATCH --output=comparison_plotter.log   # Standard output and error log


# set locations
ROOT_loc = "/hpc/dhl_ec/esmulders/"
PROJECT_loc = paste0(ROOT_loc,
                     "REGENIE_SMART/")
INPUT_loc = paste0(PROJECT_loc,
                 "RESULTS/RESULTS_IMT/")
OUTPUT_loc = paste0(INPUT_loc,
                   "plots/")

install.packages.auto <- function(x) { 
  x <- as.character(substitute(x)) 
  if (isTRUE(x %in% .packages(all.available = TRUE))) { 
    eval(parse(text = sprintf("require(\"%s\")", x)))
  } else { 
    # Update installed packages - this may mean a full upgrade of R, which in turn
    # may not be warrented. 
    #update.packages(ask = FALSE) 
    eval(parse(text = sprintf("install.packages(\"%s\", dependencies = TRUE, repos = \"http://cran-mirror.cs.uu.nl/\")", x)))
  }
  if (isTRUE(x %in% .packages(all.available = TRUE))) { 
    eval(parse(text = sprintf("require(\"%s\")", x)))
  } else {
    source("http://bioconductor.org/biocLite.R")
    # Update installed packages - this may mean a full upgrade of R, which in turn
    # may not be warrented.
    #biocLite(character(), ask = FALSE) 
    eval(parse(text = sprintf("biocLite(\"%s\")", x)))
    eval(parse(text = sprintf("require(\"%s\")", x)))
  }
}

install.packages.auto("data.table")
install.packages.auto("graphics")
install.packages.auto("dplyr")


# generate tables from REGENIE and SNPTest results
RegenieResults <- read.table(paste0(INPUT_loc, "regenie.IMT.summary_results.combined.QC.txt.gz"), header = TRUE, sep = "")

RegenieResults <- data.frame(ID=RegenieResults$ID, PR=RegenieResults$P)

SNPTestResults <- read.table(paste0(ROOT_loc, "SMART_cIMT/SNP/GWAS_SMART_cIMT/snptest_results/imt_rankNorm/SMARTGS.GWAS.1kGp3v5GoNL5.imt_rankNorm.EXCL_DEFAULT.summary_results.QC.txt"), header = TRUE, sep = "")

SNPTestResults <- data.frame(ID=SNPTestResults$RSID, PS=SNPTestResults$P)

#merge results
Results <- merge(RegenieResults, SNPTestResults, by="ID", all=F)

#create output for plot
png(paste0(OUTPUT_loc, "P_comparison_QC.png"), width = 800, height = 800)
# plot (random sample of) data 
plot(Results$PS, Results$PR, 
     xlab = "Observed p-value with SNPTest", ylab = "Observed p-value with REGENIE", 
     main = "Correlation of P-values generated with SNPTest and REGENIE", col = "#1290D9", bty="n", pch = 1,
     xaxs="i", yaxs="i")
# add in a straight line
abline(0, 1, col = "#DB003F", lty = 1, xpd = FALSE)

dev.off()