#load required package
library(hudson)

# create miami plot
gmirror(top=female_hudson, bottom=male_hudson, tline=0.05/nrow(female_hudson), bline=0.05/nrow(male_hudson), 
        toptitle = "GWAS Comparison of cIMT: Female samples", bottomtitle = "GWAS Comparison of cIMT: Male samples", 
        highlight_p = c(0.05/nrow(female_hudson),0.05/nrow(male_hudson)), highlighter="dodgerblue")