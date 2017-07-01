## Parameters 
## @outcome --> type of variable that want to be analized, “heart attack” (col #13), 
##       “heart failure” (col #19), or “pneumonia” (col #25) file Outcome of Care Measures.csv
## @num --> numeric value, ranking of the hospital
## Result
## Date frame [hospital, state]
rankall <- function(outcome, num = "best") {
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
    returnOutcome <- list(state = levels(outcomeSource$State))
    returnOutcome <- tbl_df(returnOutcome)
    returnOutcome <- returnOutcome %>% arrange(state)
    
    if (sum(outcome == outcomeType) == 0) {
        return(paste("Error in best ('",state,"','",outcome,"'): invalid outcome", sep=""))
    }

    ## Rename Variables
    outcomeSource <- outcomeSource %>% rename(Heart.Attack=Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
                                              Heart.Failure=Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
                                              Pneumonia=Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia) %>% select (Hospital.Name, State, Heart.Attack, Heart.Failure, Pneumonia)
    
    ## Return hospital name in that state with lowest 30-day death
    if (outcome == "heart attack") {
        outcomeTarget <- outcomeSource %>% select(hospital=Hospital.Name, Value=Heart.Attack, state=State) %>% mutate(Value = as.numeric(Value)) %>% filter(!is.na(Value)) %>% group_by(state) %>% arrange(state,Value,hospital) %>% mutate(id=row_number())
    } else if (outcome == "heart failure") {
        outcomeTarget <- outcomeSource %>% select(hospital=Hospital.Name, Value=Heart.Failure, state=State) %>% mutate(Value = as.numeric(Value)) %>% filter(!is.na(Value)) %>% group_by(state) %>% arrange(state,Value,hospital) %>% mutate(id=row_number())
    } else if (outcome == "pneumonia") {
        outcomeTarget <- outcomeSource %>% select(hospital=Hospital.Name, Value=Pneumonia, state=State) %>% mutate(Value = as.numeric(Value)) %>% filter(!is.na(Value)) %>% group_by(state) %>% arrange(state,Value,hospital) %>% mutate(id=row_number())
    }
    
    ##Get the maximum observation value
    maxObs <- outcomeTarget %>% summarize(n=n()) %>% filter(n==max(n))

    ##Determine the column number to return
    if (is.numeric(num)) {
        if (num > maxObs[2]) {
            return("NA")
        } else {
            outcomeTarget <- outcomeTarget %>% filter(id == num) %>% select(hospital,state)
        }
    }
    else if (num == "best") {
        outcomeTarget <- outcomeTarget %>% filter(id == 1) %>% select(hospital,state)
    } else if (num == "worst") {
        outcomeTarget <- outcomeTarget %>% filter(id == n()) %>% select(hospital,state)
    }
    ## rate
    returnOutcome <- merge(returnOutcome, outcomeTarget, by="state", all.x = TRUE)
    return(returnOutcome)
}