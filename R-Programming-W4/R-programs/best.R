## Parameters 
## @state --> 2 character name, col #7 file Outcome of Care Measures.csv
## @outcome --> type of variable that want to be analized, “heart attack” (col #13), 
##       “heart failure” (col #19), or “pneumonia” (col #25) file Outcome of Care Measures.csv
## Result
## Name (col #2) of the best (lowest) hospital sorted by name
best <- function(state, outcome) {
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
    outcomeSource <- outcomeSource %>% rename(Heart.Attack=Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,
                                              Heart.Failure=Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure,
                                              Pneumonia=Lower.Mortality.Estimate...Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia)

    ## Check that state and outcome are valid
    stateLevels <- levels(outcomeSource$State)
    if (sum(outcome == outcomeType) == 0) {
        return(paste("Error in best ('",state,"','",outcome,"'): invalid outcome", sep=""))
    }
    if (sum(state == stateLevels) == 0) {
        return(paste("Error in best ('",state,"','",outcome,"'): invalid state", sep=""))
    }

    ## Return hospital name in that state with lowest 30-day death
    if (outcome == "heart attack") {
        outcomeTarget <- outcomeSource %>% select(Hospital.Name, Heart.Attack, State) %>% mutate(Heart.Attack = as.numeric(Heart.Attack)) %>% filter(State == state) %>% arrange(Heart.Attack, Hospital.Name)
    } else if (outcome == "heart failure") {
        outcomeTarget <- outcomeSource %>% select(Hospital.Name, Heart.Failure, State) %>% mutate(Heart.Failure = as.numeric(Heart.Failure)) %>% filter(State == state) %>% arrange(Heart.Failure, Hospital.Name)
    } else if (outcome == "pneumonia") {
        outcomeTarget <- outcomeSource %>% select(Hospital.Name, Pneumonia, State) %>% mutate(Pneumonia = as.numeric(Pneumonia)) %>% filter(State == state) %>% arrange(Pneumonia, Hospital.Name)
    }
    ## rate    
    outcomeTarget$Hospital.Name[1]
}