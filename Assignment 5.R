library(gapminder)
library(tidyverse)
library(ggrepel)
library(socviz)

# Read the files

Scores <- read.csv("school_scores.csv") 

# Create map data frame
library(maps)
us_states <- map_data("state")
head(us_states)
dim(us_states)

# Plotting map data

p <- ggplot(data = us_states,
            mapping = aes(x = long, y = lat,
                          group = group))

p + geom_polygon(fill = "white", color = "black")

# Coloring the states

p <- ggplot(data = us_states,
            aes(x = long, y = lat,
                group = group, fill = region))

p + geom_polygon(color = "gray90", size = 0.1) + guides(fill = FALSE)


# Creating a column to merge election data and map data on, then doing left_join()
sum_total <- sum(new_scores$Total.Test.takers)

new2 <- mutate(new_scores,percentage=new_scores$Total.Test.takers/sum_total)

new2$region <- tolower(new2$State.Name)

us_states_test <- left_join(us_states,new2)


# Plotting the joined data set

p0 <- ggplot(data = us_states_test,
             mapping = aes(x = long, y = lat, group = group, fill= percentage))

p1 <- p0 + geom_polygon(color = "gray90", size = 0.1) +
  coord_map(projection = "albers", lat0 = 39, lat1 = 45)+ labs(title = "states with percentage of test takers in 2007") 
p1