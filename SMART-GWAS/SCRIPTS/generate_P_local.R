

ROOT_loc = "/Users/esmulde2/"
GITHUB_loc = paste0(ROOT_loc, 
                    "Documents/GitHub/")
PROJECT_loc = paste0(GITHUB_loc,
                     "REGENIE_SMART/")
DATA_loc = paste(PROJECT_loc,
                 "DATA/")
REGENIE_loc = paste0(PROJECT_loc,
                     "OUTPUT_REGENIE/")
SNP_loc = paste0(PROJECT_loc,
                 "SNP/")
  
#library(readr)
#library(tidyverse)
library(data.table)
#library(tableone)
#library(labelled)
#library(sjlabelled)
  
# collect all the SNPstats files

fileNames <- Sys.glob(paste0(REGENIE_loc, "*.regenie"))

# rank the files in sequence for loop function

fileNumbers <- seq(fileNames)

  # create loop that goes through each file, filters that file, and writes to new output file
  
  for (fileNumber in fileNumbers) {
    
    # read data:
    output_regenie <- read.table(fileNames[fileNumber], header = TRUE, sep = "")
    
    # filter SNPs with imputation quality under 99%                           
    output_regenie$P <- 10^output_regenie$LOG10P
    
    
    # create names for output file
    newFileName <- paste("IMT",
                         fileNumber,
                         ".", "regenie", sep = "")
    
    # create output file
    fwrite(output_regenie,
           file = paste0(REGNIE_loc, newFileName),
           na = "NA", sep = " ", quote = FALSE,
           row.names = FALSE, col.names = TRUE,
           showProgress = TRUE, verbose = TRUE)
  }