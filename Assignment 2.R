library(dplyr)
US <- read.csv("us-states.csv")
Penn <- filter(US,state=="Pennsylvania")
View(Penn)

n <- length(Penn$date)
incr_cases <- 1
for (i in 2:n) {
  incr_cases[i] <- (Penn$cases[i]-Penn$cases[i-1]) 
}
incr_cases
sum(incr_cases)
sd(incr_cases)

incr_deaths <- 1
for (i in 2:n) {
  incr_deaths[i] <- (Penn$deaths[i]-Penn$deaths[i-1]) 
}
incr_deaths
sum(incr_deaths)

