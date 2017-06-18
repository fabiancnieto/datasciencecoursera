complete <- function(directory, id = 1:32) {
    index <- 0
    filedata <- NULL
    obs <- NULL
    nobs <- NULL
    summatrix <- NULL
    strfile <- NULL
    strpath <- NULL
    nasvalues <- NULL
    
    for (files in id) {
        #Read the CSV files specifiied in the id variable
        index <- index +1
        strfile <- sprintf("%03d", files)
        strpath <- paste(directory, "/", strfile, ".csv", sep="")
        if (file.exists(strpath)) {
            filedata <- read.csv(strpath, header=TRUE)
            nasvalues <- is.na(filedata)
            nasvalues <- !nasvalues
            obs <- apply(nasvalues, 1, prod)
            nobs <- sum(obs)
            if (files == id[1] ) {
                #Fisrt file to load
                summatrix <- matrix(c(files, nobs), nrow=1, ncol=2, byrow = TRUE) 
            } else {
                summatrix <- rbind(summatrix, c(files, nobs))
            }
        }
    }
    colnames(summatrix) <- c("id","nobs")
    rownames(summatrix) <- c(1:index)
    summatrix
 }