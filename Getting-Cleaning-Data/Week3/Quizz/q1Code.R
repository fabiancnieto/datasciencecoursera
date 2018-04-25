library(dplyr)
##Download the file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2Fss06hid.csv", "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/q1data.csv")

##Download the code book
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fdata%2FPUMSDataDict06.pdf", "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/q1data_code_book.pdf")

##Load the file and transform in a data frame
csvFile <- read.csv("/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/q1data.csv")
dfFile <- tbl_df(csvFile)

##Filter identifies the households on greater than 10 acres who sold more than $10,000 worth of agriculture products
agricultureLogical <- dfFile %>% select(ACR, AGS)
agricultureLogical <- agricultureLogical$ACR == 3 & agricultureLogical$AGS == 6
which(agricultureLogical)


agricultureLogical <- csvFile[csvFile$ACR == 3 & csvFile$AGS == 6]