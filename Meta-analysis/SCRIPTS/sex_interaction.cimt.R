#MWY: the main reference for this interaction analysis
# https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1005378#sec017

samplesize_f <- 35019
samplesize_m <- 35215

ss_m <- "/Users/esmulde2/Documents/Stage/Results/METAGWAS/males/male_interaction.txt"
ss_f <- "/Users/esmulde2/Documents/Stage/Results/METAGWAS/females/female_interaction.txt"

library("data.table")
library("dplyr")
library("tidyverse")

#get_intP_table_toClumping<-function(ss_f,ss_m,samplesize_f,samplesize_m,loci_vec=NULL){
  

  samplesizef<-as.integer(samplesize_f)
  samplesizem<-as.integer(samplesize_m)
  samplesize<-samplesizef+samplesizem
  #https://onlinecourses.science.psu.edu/stat501/node/297
  degreesoffreedom= as.numeric(samplesize)-4
 
  
  message("read files from path.....")
  # the summary statistics files look like this
  # uniqid  SNP     CHR     BP      GENPOS  ALLELE1 ALLELE0 A1FREQ  INFO    BETA    SE      pval
  # 1:10177_A_AC    rs367896724     1       10177   0       A       AC      0.598476        0.467935        0.00749457      0.011557        5.2E-01
  # 1:10352_T_TA    rs201106462     1       10352   0       T       TA      0.605085        0.447895        -0.000372271    0.0118711       9.7E-01
  # 1:10616_C_CCGCCGTTGCAAAGGCGCGCCG        1:10616_CCGCCGTTGCAAAGGCGCGCCG_C        1       10616   0       CCGCCGTTGCAAAGGCGCGCCG  C       0.00625549      0.468098        -0.179952       0.0714333       1.2E-02
  
  print(ss_f)
  df_f<-fread(ss_f)
  print(nrow(df_f))
  print(ss_m)
  df_m<-fread(ss_m)
  print(nrow(df_m))
  
  
  
  message("merge 2 summary statistics")
  dfMerged<-merge(df_f,df_m, by=c("VARIANTID", "CHR", "POS"))
  
  # a priori filter mentioned in the article, see figure 1. (this will affect the rspearman and hence change the results. Use with caution.) 
  # dfMerged<-dfMerged[dfMerged$uniqid %in% overall_apriori_snps ,]
  
  print(nrow(dfMerged))
  message("compute Spearman correlation")
  rspearman=cor(cbind(dfMerged$BETA_FIXED.x,dfMerged$BETA_FIXED.y) , method="spearman",use="pairwise.complete.obs")[1,2]
  
  #https://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1005378#sec017   Genome-wide screening approaches to detect interaction effects
  message("compute the t-statistics")
  dfMerged$Tint=(dfMerged$BETA_FIXED.x - dfMerged$BETA_FIXED.y)/sqrt(  (dfMerged$SE_FIXED.x^2) + (dfMerged$SE_FIXED.y^2) - 2 * rspearman*(dfMerged$SE_FIXED.x) * (dfMerged$SE_FIXED.y))
  message("derive p-values")
  dfMerged$Pint=2*pt(abs(dfMerged$Tint), degreesoffreedom, lower=FALSE)

  
  # this is just for subsetting the file for quick lookup
#  if (!is.null(loci_vec)){
 #   dfMerged<-dfMerged[dfMerged$SNP.x %in% loci_vec,]
#    
 # }
  

  return(dfMerged)
#}

  fwrite(dfMerged,
         file = "/Users/esmulde2/Documents/Stage/Results/METAGWAS/interaction_cimt.txt",
         na = "NA", sep = "\t", quote = FALSE,
         row.names = FALSE, col.names = TRUE,
         showProgress = TRUE, verbose = TRUE)
 
  
  # create files for plotting
   
  interaction <- dfMerged[-1,]
  interaction <- interaction %>% 
    select("Pint")
  
  fwrite(interaction,
         file = "/Users/esmulde2/Documents/Stage/Results/METAGWAS/interaction_pint.txt",
         na = "NA", sep = "\t", quote = FALSE,
         row.names = FALSE, col.names = FALSE,
         showProgress = TRUE, verbose = TRUE)

  interaction <- dfMerged[-1,]
  interaction <- interaction %>% 
    select("CHR", "POS", "Pint")
  
  fwrite(interaction,
         file = "/Users/esmulde2/Documents/Stage/Results/METAGWAS/interaction_manhatten.txt",
         na = "NA", sep = "\t", quote = FALSE,
         row.names = FALSE, col.names = FALSE,
         showProgress = TRUE, verbose = TRUE)
  
  
