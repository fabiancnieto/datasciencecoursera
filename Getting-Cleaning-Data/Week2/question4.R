#load library httr
library(httr)

#Get the content page
page<- url("http://biostat.jhsph.edu/~jleek/contact.html")

#read gtml file by lines
html<-readLines(page)

#Count the number of characteres per line
chrvector <- c(nchar(html[10]),nchar(html[20]),nchar(html[30]),nchar(html[100]))
