# Jinyi Xu
# BIS244 Section011
# Midterm Exam

# Load packages
library(tidyverse)
library(ggplot2)
require(scales)

# Read in csv file
Result <- read.csv("AMD.csv", header=T)

Result$Date <- as.Date(Result$Date)

# Make the plot
p <- ggplot(data = Result,
            mapping = aes(
              x = Date,
              y = Adj.Close))

p  +  geom_point()+
  labs(x = "Date", y = "Adjusted Closing Price",
       title = "AMD Adjusting Closing Price 02-24-2021 to 02-24-2022",
       subtitle = "Jinyi Xu") +
  scale_x_date(labels = date_format("%b %Y"),breaks= date_breaks("12 weeks"),limits = as.Date(c("2021-02-24","2022-02-24")))
