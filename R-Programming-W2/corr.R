corr <- function(directory, threshold = 0) {
    matrixcomplete <- NULL
    matrixthreshold <- NULL
    filematrix <- NULL
    filedata <- NULL
    nitrate <- NULL
    sulfate <- NULL
    correlation <- NULL
    strfile <- NULL
    strpath <- NULL
    nasvalues <- NULL
    obs <- NULL
    id <- NULL
    
    matrixcomplete <- complete(directory, 1:332)
    matrixcomplete <- matrixcomplete[matrixcomplete[,"nobs"] > threshold,]
    
    if (class(matrixcomplete) == "matrix") {
        id <- matrixcomplete[,"id"]
    } else {
        id <- matrixcomplete["id"]
    }

    if (length(id) > 0) {
        for (files in id) {
            #Read the CSV files specifiied in the id variable
            strfile <- sprintf("%03d", files)
            strpath <- paste(directory, "/", strfile, ".csv", sep="")
            if (file.exists(strpath)) {
                filedata <- read.csv(strpath, header=TRUE)
                nasvalues <- is.na(filedata)
                nasvalues <- !nasvalues
                obs <- apply(nasvalues, 1, prod)
                filematrix <- filedata[as.logical(obs),]
                sulfate <- filematrix[,"sulfate"]
                nitrate <- filematrix[,"nitrate"]
                if (files == id[1] ) {
                    #First file to load
                    correlation <- cor(sulfate, nitrate)
                } else {
                    correlation <- c(correlation, cor(sulfate, nitrate))
                }
            }
        }
    }
    
    correlation
 }