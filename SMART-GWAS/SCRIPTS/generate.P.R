#!/hpc/local/CentOS7/dhl_ec/software/R-3.6.3/bin/Rscript 

# SLURM settings
#SBATCH --job-name=P-generater    # Job name
#SBATCH --mail-type=END,FAIL          # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=e.j.a.smulders-2@umcutrecht.nl     # Where to send mail
#SBATCH --nodes=1                     #run on one node	
#SBATCH --ntasks=1                    # Run on a single CPU
#SBATCH --mem-per-cpu=10G                    # Job memory request
#SBATCH --time=12:00:00               # Time limit hrs:min:sec
#SBATCH --output=generate_p.log   # Standard output and error log

ROOT_loc = "/hpc/dhl_ec/esmulders/"
PROJECT_loc = paste0(ROOT_loc,
                     "REGENIE_SMART/")
INPUT_loc = paste0(PROJECT_loc,
                   "RESULTS/")
OUTPUT_loc = paste0(PROJECT_loc,
                    "RESULTS/")

library("data.table")

# collect all the files

#COMBINED
  
# read data:
output_regenie <- read.table(paste0(INPUT_loc, "regenie.summary_results.combined.txt"), header = TRUE, sep = "")
  
  # Create P for -log10P                         
  output_regenie$P <- 10^-output_regenie$LOG10P
  
  
  # create names for output file
  newFileName <- paste("regenie.IMT.summary_results.combined.txt", sep = "")
  
  # create output file
  fwrite(output_regenie,
         file = paste0(OUTPUT_loc, newFileName),
         na = "NA", sep = "\t", quote = FALSE,
         row.names = FALSE, col.names = TRUE,
         showProgress = TRUE, verbose = TRUE)
  
#MALES
    
 output_regenie_male <- read.table(paste0(INPUT_loc, "regenie.summary_results.male.txt"), header = TRUE, sep = "")

# Create P for -log10P                         
 output_regenie_male$P <- 10^-output_regenie_male$LOG10P


# create names for output file
 newFileName_male <- paste("regenie.IMT.summary_results.male.txt", sep = "")

# create output file
 fwrite(output_regenie_male,
      file = paste0(OUTPUT_loc, newFileName_male),
     na = "NA", sep = "\t", quote = FALSE,
    row.names = FALSE, col.names = TRUE,
   showProgress = TRUE, verbose = TRUE)
  
#FEMALES
  
  output_regenie_female <- read.table(paste0(INPUT_loc, "regenie.summary_results.female.txt"), header = TRUE, sep = "")
  
  # Create P for -log10P                         
  output_regenie_female$P <- 10^-output_regenie_female$LOG10P
  
  
  # create names for output file
  newFileName_female <- paste("regenie.IMT.summary_results.female.txt", sep = "")
  
  # create output file
  fwrite(output_regenie_female,
         file = paste0(OUTPUT_loc, newFileName_female),
         na = "NA", sep = "\t", quote = FALSE,
         row.names = FALSE, col.names = TRUE,
         showProgress = TRUE, verbose = TRUE)
