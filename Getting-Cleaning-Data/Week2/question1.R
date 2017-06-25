#load package httr
library(httr)
#First question URL
w2q1url<-"https://api.github.com/users/jtleek/repos"

#Create a User token in Github
usrtoken<-"91ce7ff870cea45944c5e2e52add107b19594037"

#username Github
usrname<-"fabian.c.nieto@gmail.com"

#make the request following the instructions here "https://developer.github.com/v3/auth/"
w2q1content<-GET(w2q1url, add_headers(username=usrname, token=usrtoken))
w2q1content<-content(w2q1content,"text")

#load package jsonlite
library(jsonlite)
#parse the returned code to json
w2q1parsecont<-fromJSON(w2q1content)
#remove owner columns
w2q1parsecont<-subset(w2q1parsecont, select=-c(owner))

#load package dplyr
library(dplyr)
#Load data to data frame tbl
w2q1dft<-tbl_df(w2q1parsecont)

#get the value of created_at for datasharing
w2q1dft%>%filter(name == "datasharing")%>%select(created_at)
