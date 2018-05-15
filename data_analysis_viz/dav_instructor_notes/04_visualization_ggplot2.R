##' Robin Elahi
##' 15 May 2018
##' R-Ecology-Lesson
##' 04-visualization-ggplot2

##### OBJECTIVES #####

# Produce scatter plots, boxplots, and histograms using ggplot.
# Set universal plot settings.
# Describe what faceting is and apply faceting in ggplot.
# Modify the aesthetics of an existing ggplot plot (including axis labels and color).
# Build complex and customized plots from data in a data frame.

##### INTRO - ggplot2 #####

##' Key points
##' complex, beautiful plots based on dataframes and a general 'grammar'
##' ggplot2 functions like tidy data in long format
##' (column for every dimension, a row for every observation)
##' well-structured data will save you lots of time

##' basic grammar template:
##' ggplot(data = , mapping = aes()) + GEOM_FUNCTION
##' ggplot(data = surveys_complete)
##' ggplot(data = surveys_complete, mapping = aes(x = weight, y = hindfoot_length))

##' Emphasis on visualizing the data
##' Scatterplot
##' Histogram
##' Boxplot
##' Means + standard deviations

library(tidyverse)
library(viridis) # for color-blind friendly plots

## Load surveys_complete data that we prepared last week
surveys_complete <- read_csv("carpentry_training/data_output/surveys_complete.csv")
