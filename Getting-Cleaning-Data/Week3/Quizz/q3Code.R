library(dplyr)
##Download the files
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FGDP.csv", "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/GrossDomesticProduct.csv")
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FEDSTATS_Country.csv", "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/EducationData.csv")

gdpRank <- read.csv("/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/GrossDomesticProduct.csv", stringsAsFactors=FALSE)
eduStats <- read.csv("/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/EducationData.csv", stringsAsFactors=FALSE)

gdpRank <- tbl_df(gdpRank)
eduStats <- tbl_df(eduStats)

###Question #3
##Filter gdpRank file by the observations with a vaue for rank
gdpRank <- gdpRank %>% mutate(gdp=as.numeric(Gross.domestic.product.2012))
gdpRank <- gdpRank %>% filter(!is.na(gdp))

##Merge the files
mergeFiles <- merge(gdpRank, eduStats, by.x = "X", by.y = "CountryCode") %>% arrange(desc(gdp))

##Number of rows matched
nrow(mergeFiles)

##Show 13th row
mergeFiles[13,]

##Question #4
##Get the value for 
by_Income.Group <- group_by(mergeFiles, Income.Group)
by_Income.Group %>% summarize(avg_gdprank = mean(gdp))

##Question #5
##Get Quantile
by_Income.Group$gdpGroups <- cut(by_Income.Group$gdp, breaks=quantile(by_Income.Group$gdp, probs = seq(0, 1, 0.20)))
table(by_Income.Group$gdpGroups, by_Income.Group$Income.Group)