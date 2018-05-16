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

# install.packages("tidyverse")
library(tidyverse)
# install.packages("viridis")
library(viridis) # for color-blind friendly plots

## Load surveys_complete data that we prepared last week
surveys_complete <- read_csv("data_output/surveys_complete.csv")

#### GEOM_POINT ####

ggplot(data = surveys_complete, 
       mapping = aes(x = weight, y = hindfoot_length)) +
  geom_point()

## Save the mapping
surveys_plot <- ggplot(data = surveys_complete, 
                       mapping = aes(x = weight, y = hindfoot_length))

surveys_plot + geom_point()

## Add color to plot, use alpha
ggplot(surveys_complete, aes(weight, hindfoot_length)) + 
  geom_point(alpha = 0.1, color = "blue")

## Color by species_id
ggplot(surveys_complete, aes(weight, hindfoot_length, color = species_id)) + 
  geom_point(alpha = 0.1) + 
  scale_color_viridis(discrete = TRUE)

### Challenge 1 ###
# Use what you just learned to create a plot of weight over species_id with the plot types showing in different colors.

names(surveys_complete)

# Is this a good way to show this type of data?
 ggplot(surveys_complete, aes(x = species_id, y = weight, color = plot_type)) + 
   geom_point()

 #### GEOM_BOXPLOT ####
 
 ggplot(surveys_complete, aes(species_id, weight)) + 
   geom_boxplot()
 
 ggplot(surveys_complete, aes(species_id, weight)) + 
   geom_boxplot() + 
   geom_jitter(alpha = 0.3, color = "tomato")

 ggplot(surveys_complete, aes(species_id, weight)) + 
   geom_jitter(alpha = 0.3, color = "tomato") + 
   geom_boxplot(alpha = 0.3)

 
 ### Challenge 2 ###
 ##  Start with the boxplot we created:
 ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
   geom_boxplot(alpha = 0) +
   geom_jitter(alpha = 0.3, color = "tomato")
 
 ##  1. Replace the box plot with a violin plot; see `geom_violin()`.
 ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
   geom_violin(alpha = 0) +
   geom_jitter(alpha = 0.3, color = "tomato")
 
 ##  2. Represent weight on the log10 scale; see `scale_y_log10()`.
 ggplot(data = surveys_complete, aes(x = species_id, y = weight)) +
   geom_jitter(alpha = 0.3, color = "tomato") + 
   geom_violin(alpha = 0) + 
   scale_y_log10()
   
 ##  3. Create boxplot for `hindfoot_length` by species_id, overlaid on a jitter layer of the raw data (hindfoot_length).

ggplot(data = surveys_complete, aes(x = species_id, y = hindfoot_length)) +
  geom_jitter(alpha = 0.3, color = "tomato") + 
  geom_boxplot(alpha = 0) 
 
 ##  4. Add color to the data points on your boxplot according to the
 ##  plot from which the sample was taken (`plot_id`).
 ##  *Hint:* Check the class for `plot_id`. Consider changing the class
 ##  of `plot_id` from integer to factor. Why does this change how R
 ##  makes the graph?  

str(surveys_complete)
class(surveys_complete$plot_id)

ggplot(data = surveys_complete, 
       aes(x = species_id, y = hindfoot_length, color = plot_id)) +
  geom_jitter(alpha = 0.3) + 
  geom_boxplot(alpha = 0) 

surveys_complete <- surveys_complete %>% 
  mutate(plot_id = as.factor(plot_id))

## Reorder by weight
surveys_complete <- surveys_complete %>% 
  mutate(species_id = reorder(species_id, -weight, FUN = median))
  
ggplot(surveys_complete, aes(species_id, weight)) + 
  geom_boxplot()

#### GEOM_HIST ####

surveys_complete %>% 
  ggplot(aes(weight)) + 
  geom_histogram() + 
  facet_wrap(~ species_id)

## Focus on one species
surveys_complete %>% 
  filter(species_id == "DM") %>% 
  ggplot(aes(weight)) + 
  geom_histogram() + 
  facet_wrap(~ species_id)

## Fill by sex; adjust bin width
surveys_complete %>% 
  filter(species_id == "DM") %>% 
  ggplot(aes(weight, fill = sex)) + 
  geom_histogram(alpha = 0.5, binwidth = 1) + 
  facet_wrap(~ species_id)

#### SUMMARY STATS AND ERROR BARS ####

### Challenge 3 ###

## We often want to plot point estimates (e.g., mean) 
## along with a measure of uncertainty (e.g., standard deviation)

#' 1. First create a new dataframe, called 'surveys_summary', that summarises weight by species_id - calculate the mean, standard deviation, and sample size (n).

#' 2. Plot mean body weight against species_id

#' 3. Using the size of points, indicate the number of samples used to calculate each mean body size
#' hint 1: use the size argument in the aes() mapping)
#' hint 2: http://ggplot2.tidyverse.org/reference/geom_point.html

#' 4. On the previous plot, add error bars for the standard deviation
#' hint(use a new layer, called geom_errorbar())

# 1. 
surveys_summary <- surveys_complete %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id) %>% 
  summarise(wt_mean = mean(weight), 
            wt_sd = sd(weight), 
            n = n())
surveys_summary

# 2.
surveys_summary %>% 
  ggplot(aes(species_id, wt_mean)) + 
  geom_point()

# 3. 
surveys_summary %>% 
  ggplot(aes(species_id, wt_mean)) + 
  geom_point(aes(size = n))

# 4. 
surveys_summary %>% 
  ggplot(aes(species_id, wt_mean)) + 
  geom_point(aes(size = n)) + 
  geom_errorbar(aes(ymin = wt_mean - wt_sd, 
                ymax = wt_mean + wt_sd))

#### EXPORTING ####

surveys_summary %>% 
  ggplot(aes(species_id, wt_mean)) + 
  geom_point(aes(size = n)) + 
  geom_errorbar(aes(ymin = wt_mean - wt_sd, 
                    ymax = wt_mean + wt_sd)) + 
  theme_bw(base_size = 14)

ggsave("carpentry_training/fig_output/fig1.pdf", 
       height = 3.5, width = 5)

### Challenge 4 ###
## Tweaking the plot
## Try to change axis labels; add figure title (hint: labs())
## Try to remove the gray panel gridlines (hint: theme())
## Try to change the error bar widths (hint: geom_errorbar())
## Try to place the legend on the bottom of the figure
# https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf


### Challenge 5 ###
## Try to add the original data points to the plot
## Hint: use geom_jitter as before

