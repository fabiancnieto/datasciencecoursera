## R Programming Course assigment week 3 example caching computations
## First function has functions to help determine if exists a chached 
## value and if not exists compute the mean of the vector

## The first function, makeVector creates a special "vector", which is really a list containing a function to
## 1. set the value of the vector 2. get the value of the vector 3. set the value of the mean
## 4. get the value of the mean

makeVector <- function(x = numeric()) {
    m <- NULL
    set <- function(y) {
        x <<- y
        m <<- NULL
    }
    get <- function() x
    setmean <- function(mean) m <<- mean
    getmean <- function() m
    list(set = set, get = get,
         setmean = setmean,
         getmean = getmean)
}


## Calculate the mean of a given vector, verify if the mean its already calculated
## x parameter must be a makeVector object

cacheMean <- function(x, ...) {
    m <- x$getmean()
    if(!is.null(m)) {
        message("getting cached data")
        return(m)
    }
    data <- x$get()
    m <- mean(data, ...)
    x$setmean(m)
    m
}
