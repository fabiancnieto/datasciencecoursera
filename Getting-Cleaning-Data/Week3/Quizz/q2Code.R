library(dplyr)
library(jpeg)
##Download the file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fjeff.jpg", "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/q2image.jpg")

##Read the image
dataImg <- readJPEG("/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week3/Quizz/q2image.jpg", native = TRUE)

quantile(dataImg, probs=c(0.3, 0.8))