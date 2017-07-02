## R Programming Course assigment week 3 caching computations of a matrix inverse 
## First function has functions to help determine if exists a chached 
## value and if not exists compute the inverse of a matrix

## The first function, makeCacheMatrix creates a special "matrix", which is really a list containing a function to
## 1. set the value of the matrix 2. get the value of the matrix 
## 3. set the value of the matrix inverse 4. get the value of the matrix inverse

makeCacheMatrix <- function(x = matrix()) {
    matrixinv <- NULL
    set <- function(y) {
        x <<- y
        matrixinv <<- NULL
    }
    get <- function() x
    setmatrixinv <- function(minverse) matrixinv <<- minverse
    getmatrixinv <- function() matrixinv
    list(set = set, get = get,
         setmatrixinv = setmatrixinv,
         getmatrixinv = getmatrixinv)
}


## Calculate the inverse of a given matrix, verify if the inverse its already calculated
## x parameter must be a makeCacheMatrix object

cacheSolve <- function(x, ...) {
    data <- x$get()
    if (class(data) == "matrix") {
        minverse <- x$getmatrixinv()
        if(!is.null(minverse)) {
            message("getting cached data")
            return(minverse)
        }
        dimdata <- dim(data)
        if (dimdata[1] != dimdata[2]) {
            message("x is not a symmetric matrix!!")
            return(NULL)
        }
        minverse <- solve(data, ...)
        x$setmatrixinv(minverse)
        minverse
    } else {
        message("x is not a matrix!!")
        return(NULL)
    }

}
