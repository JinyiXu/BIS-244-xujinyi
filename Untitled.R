# Jinyi Xu
# BIS244 Section011
# Midterm Exam

# Clear out
rm(list=ls(all=TRUE))
cat("\014")

# Load packages
library(tidyverse)
if (!require("here")) install.packages("here")
library(here)
library(ggplot2)

# Read in csv file
Result <- read.csv("AMD.csv")
Result


# Make the plot
p <- ggplot(data = Result,
            mapping = aes(
              x = Date,
              y = Adj.Close))

p +  geom_point() + 
  labs(x = "Date", y = "Adjusted Closing Price",
       title = "AMD Adjusting Closing Price 02-24-2021 to 02-24-2022",
       subtitle = "Jinyi Xu") + theme(axis.text.x=element_blank())
