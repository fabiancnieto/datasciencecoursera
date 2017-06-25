#set workdirectory to the path of files
setwd("/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/Getting-Cleaning-Data/Week2")
#Load the csv file into the variable
acs<-file("getdatadatass06pid.csv")

#load the sqldf library
library(sqldf)

#verify the sql statment
sqldf("select pwgtp1 from acs where AGEP<50")

#verify the 3 question statement
sqldf("select distinct AGEP from acs")