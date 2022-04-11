# Jinyi Xu

# Clear out
rm(list=ls(all=TRUE))
cat("\014")

if (!require("here")) install.packages("here")
library("here")

library(tidyverse)

# read the PRESIDENT_precinct_general file 

# TAA Failed to follow directions to (a) put in /Data folder and (b)
# use read_csv to read zip file, not unzip it.
RESULTS <- read_csv("Data/PRESIDENT_precinct_general.zip") 

# Making candidate and state factor variables
RESULTS$candidate <- as.factor(RESULTS$candidate)
RESULTS$state <- as.factor(RESULTS$state)
n_candidates <- length(levels(RESULTS$candidate))
n_states <- length(levels(RESULTS$state))

# dplyr approach
RESULTS <- group_by(RESULTS, state, candidate)
COUNTS1 <- summarise(RESULTS, votes = sum(votes))

# Determining unique values for states and candidates factors
STATES <- levels(RESULTS$state)
CANDIDATES <- levels(COUNTS1$candidate)

# Replacing multiple variables/instances 
COUNTS1 <- mutate(COUNTS1,cand_cons=case_when(candidate =="JOSEPH R BIDEN" ~ "BIDEN",
                                              candidate == "DONALD J TRUMP" ~ "TRUMP",
                                              TRUE ~ "OTHER"))
CAND_CONS <- levels(as.factor(COUNTS1$cand_cons))
CAND_CONS

RESULTS <- group_by(COUNTS1, state, cand_cons)
COUNTS2 <- summarise(RESULTS, votes = sum(votes))

n_COUNTS2 <- length(COUNTS2$state)
COUNTS3 <- data.frame(STATES)
COUNTS3
COUNTS3$votes <- 0
COUNTS3$winner <- NA
for (i in 1:n_states) {
  BIDEN <- 0
  TRUMP <- 0
  VOTES <- 0
  for (j in 1:n_COUNTS2){
    if (COUNTS2$state[j]==COUNTS3$STATES[i]){
      VOTES <- VOTES + COUNTS2$votes[j]
      if (COUNTS2$cand_cons[j]=="BIDEN") {
        BIDEN <- BIDEN + COUNTS2$votes[j]
      }
      else if (COUNTS2$cand_cons[j]=="TRUMP") {
        TRUMP <- TRUMP + COUNTS2$votes[j]
      }
      else {}
    }
  }
  COUNTS3$votes[i] <- VOTES
  if (BIDEN > TRUMP) {
    COUNTS3$winner[i] <- "BIDEN"
  }
  else COUNTS3$winner[i] <- "TRUMP"
}
winner <- COUNTS3$winner
winner
# Make scatter chart
View(COUNTS2)
str(COUNTS2)

COUNTS2$cand_cons <- as.factor(COUNTS2$cand_cons)
head(COUNTS2)


library(ggplot2)
ggplot(COUNTS3, aes(x = votes, y = STATES, color = winner)) + geom_point() + ggtitle("Vote Results of President Selection")
