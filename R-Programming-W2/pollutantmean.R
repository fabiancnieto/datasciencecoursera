pollutantmean <- function(directory, pollutant, id = 1:32) {
    filedata <- NULL
    filematrix <- NULL
    strfile <- NULL
    strpath <- NULL
    for (files in id) {
        #Read the CSV files specifiied in the id variable
        strfile <- sprintf("%03d", files)
        strpath <- paste(directory, "/", strfile, ".csv", sep="")
        if (file.exists(strpath)) {
            filedata <- read.csv(strpath, header=TRUE)
            if (files == id[1] ) {
                #Fisrt file to load
                filematrix <- filedata
            }
            filematrix <- merge(filematrix,filedata, all=TRUE)
        }
    }
    #Calculate the value of the pollutant indicating by the parameter pollutant
    mean(filematrix[,c(pollutant)],na.rm=TRUE)
}