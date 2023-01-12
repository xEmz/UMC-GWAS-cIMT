

#set_loc
ROOT_loc = "/Users/esmulde2/"
RESULTS_loc = paste0(ROOT_loc, 
                    "Documents/Stage/Results/")
PROJECT_loc = paste0(RESULTS_loc,
                     "METAGWAS/")


#load packages
#library(RACER)
library(data.table)
library(tidyverse)
library(readxl)
library(dplyr)


male_forest <- read_excel(paste0(PROJECT_loc, "males/male_clumped.xlsx"))

female_forest <- read_excel(paste0(PROJECT_loc, "females/female_clumped.xlsx"))


ggplot(data=male_forest, aes(y=Index, x=effect, xmin=lower, xmax=upper, size = `-log10P`)) +
  geom_point() +
  geom_errorbarh(height=.1) +
  xlim(-0.05, 0.05) +
  ggtitle("Effect size of lead variant in GWAS clumps") +
  xlab("Effect Size (BETA±SE") +
  geom_text(aes(label = SNP), check_overlap = TRUE, hjust=0, vjust=-1.2, size = 3) +
  geom_point(color='black') +
  scale_y_continuous(name = "Gene", breaks=1:nrow(female_forest), labels=male_forest$Gene)


ggplot(data=female_forest, aes(y=Index, x=effect, xmin=lower, xmax=upper, size = `-log10P`)) +
  geom_point() +
  geom_errorbarh(height=.1) +
  xlim(-0.05, 0.05) +
  ggtitle("Effect size of lead variant in GWAS clumps") +
  xlab("Effect Size (BETA±SE") +
  geom_text(aes(label = SNP), check_overlap = TRUE, hjust=0, vjust=-1.2, size = 3) +
  geom_point(color='black') +
  scale_y_continuous(name = "Gene", breaks=1:nrow(female_forest), labels=mfeale_forest$Gene)

