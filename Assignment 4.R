# Jinyi Xu

# Load packages
library(tidyverse)
library(scales)
library(ggrepel)

Movies <- read_csv("Top_10000_Popular_Movies.csv")
str(Movies)
Movies$year <- format(as.Date(Movies$release_date), format = "%Y")
Movies <- Movies[which(Movies$year>="2020" & Movies$year<="2021"),]

ggplot(data = Movies,
            mapping = aes(x = release_date, y = popularity)) + geom_point() +
  geom_text_repel(data = subset(Movies, popularity > 500,
                                max.overlaps = Inf),
                  mapping = aes(label = original_title)) +
  labs(x = "Release Date",
       y = "Popularity Score",
       title = "Top 10,000 Most Popular Movies") +
  scale_y_continuous(labels = scientific)
