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
            filematrix <- merge(filematrix,filedata, all=TRUE)
        }
    }
    mean(filematrix[,c(pollutant)],na.rm=TRUE)
}