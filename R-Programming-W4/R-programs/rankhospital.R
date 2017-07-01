## Parameters 
## @state --> 2 character name, col #7 file Outcome of Care Measures.csv
## @outcome --> type of variable that want to be analized, “heart attack” (col #13), 
##       “heart failure” (col #19), or “pneumonia” (col #25) file Outcome of Care Measures.csv
## @num --> numeric value, ranking of the hospital
## Result
## Name (col #2) of the hospital in that ranking sorted by name
rankhospital <- function(state, outcome, num = "best") {
    #load dplyr package
    library(dplyr)
    ##Initial variables
    outcomeType <- c("heart attack","heart failure","pneumonia")
    
    ## Read outcome data
    outcomeFile <- "/home/fnieto/Documents/R-Programming-Training/datasciencecoursera/R-Programming-W4/rprogdataProgAssignment3-data/outcome-of-care-measures.csv"
    outcomeDf <- read.csv(outcomeFile, colClasses="character")
    outcomeSource <- tbl_df(outcomeDf)
    
    ##Data type conversion for the working columns
    ##State col#7
    outcomeSource <- outcomeSource %>% mutate(State=factor(State))

    ## Check that state and outcome are valid
    stateLevels <- levels(outcomeSource$State)
    if (sum(outcome == outcomeType) == 0) {
        return(paste("Error in best ('",state,"','",outcome,"'): invalid outcome", sep=""))
    }
    if (sum(state == stateLevels) == 0) {
        return(paste("Error in best ('",state,"','",outcome,"'): invalid state", sep=""))
    }
    
    ## Rename Variables
    outcomeSource <- outcomeSource %>% rename(Heart.Attack=Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
                                              Heart.Failure=Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
                                              Pneumonia=Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)

    ## Return hospital name in that state with lowest 30-day death
    if (outcome == "heart attack") {
        outcomeTarget <- outcomeSource %>% select(Hospital.Name, Value=Heart.Attack, State) %>% mutate(Value = as.numeric(Value)) %>% filter(State == state & !is.na(Value)) %>% arrange(Value, Hospital.Name)
    } else if (outcome == "heart failure") {
        outcomeTarget <- outcomeSource %>% select(Hospital.Name, Value=Heart.Failure, State) %>% mutate(Value = as.numeric(Value)) %>% filter(State == state & !is.na(Value)) %>% arrange(Value, Hospital.Name)
    } else if (outcome == "pneumonia") {
        outcomeTarget <- outcomeSource %>% select(Hospital.Name, Value=Pneumonia, State) %>% mutate(Value = as.numeric(Value)) %>% filter(State == state & !is.na(Value)) %>% arrange(Value, Hospital.Name)
    }
    
    ##Add Rank Column
    outcomeTarget <- outcomeTarget %>% mutate(Id = seq.int(nrow(outcomeTarget)))

    ##Determine the column number to return
    if (is.numeric(num)) {
        if (num > nrow(outcomeTarget)) {
            return("NA")
        } else {
            outcomeTarget <- outcomeTarget %>% filter(Id == num)
            return(outcomeTarget$Hospital.Name[1])
        }
    }
    else if (num == "best") {
        nreturn <- 1
    } else if (num == "worst") {
        nreturn <- nrow(outcomeTarget)
    }
    ## rate
    return(outcomeTarget$Hospital.Name[nreturn])
}