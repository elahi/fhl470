##' Robin Elahi 
##' dplyr
##' 2018-05-04

## These notes are based on:
## <https://github.com/datacarpentry/R-ecology-lesson/blob/master/03-dplyr.Rmd>

#### OBJECTIVES ####
# Describe the purpose of the **`dplyr`** and **`tidyr`** packages.
# Select certain columns in a data frame with the **`dplyr`** function `select`.
# Select certain rows in a data frame according to filtering conditions with the **`dplyr`** function `filter` .
# Link the output of one **`dplyr`** function to the input of another function with the 'pipe' operator `%>%`.
# Add new columns to a data frame that are functions of existing columns with `mutate`.
# Use the split-apply-combine concept for data analysis.
# Use `summarize`, `group_by`, and `count` to split a data frame into groups of observations, apply a summary statistics for each group, and then combine the results.
# Describe the concept of a wide and a long table format and for which purpose those formats are useful.
# Describe what key-value pairs are.
# Reshape a data frame from long to wide format and back with the `spread` and `gather` commands from the **`tidyr`** package.
# Export a data frame to a .csv file.

##### DATA MANIPULATION - INTRO #####

download.file("https://ndownloader.figshare.com/files/2292169",
              "data/portal_data_joined.csv")

install.packages("tidyverse")
library(tidyverse)

library(dplyr)
library(tidyr)

# surveys <- read.csv("data/portal_data_joined.csv")
# class(surveys)
# surveys

## When you use read_csv, strings are NOT coerced to factors (instead, they are character vectors)
surveys <- read_csv("data/portal_data_joined.csv")
class(surveys)

## Inspect the data
surveys
View(surveys)

##### DPLYR FUNCTIONS #####

#' select
#' filter
#' mutate
#' group_by
#' summarise
#' arrange
#' count

surveys <- tbl_df(surveys)
class(surveys)

select(surveys, plot_id, species_id, weight)

filter(surveys, year == 1995)

## Pipes
## select and filter at the same time?

## intermediate step
surveys2 <- filter(surveys, weight < 5)
surveys_sml <- select(surveys2, species_id, sex, weight)

## nest functions
surveys_sml <- select(filter(surveys, weight < 5), 
                      species_id, sex, weight)

## pipe: %>%
## control + shift + M (shortcut)

surveys_sml <- surveys %>% 
  filter(., weight < 5) %>% 
  select(., species_id, sex, weight)

### Challenge 1
##  Using pipes, subset the data to include individuals collected
##  before 1995, and retain the columns `year`, `sex`, and `weight.`

surveys %>% 
  filter(year < 1995) %>% 
  select(year, sex, weight)
  
##### MUTATE #####

## one new column
surveys2 <- surveys %>% 
  mutate(weight_kg = weight / 1000)

## two new columns
surveys2 <- surveys %>% 
  mutate(weight_kg = weight / 1000, 
         weight_kg2 = weight_kg * 2)
  
## remove NAs
surveys2 <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight / 1000)

weight_kg <- surveys2$weight_kg
weight_kg <- surveys$weight / 1000

### Challenge 2:
##  Create a new data frame from the `surveys` data that meets the following
##  criteria: contains only the `species_id` column and a column that
##  contains values that are half the `hindfoot_length` values (e.g. a
##  new column `hindfoot_half`). In this `hindfoot_half` column, there are
##  no NA values and all values are < 30.

##  Hint: think about how the commands should be ordered to produce this data frame!

surveys_hindfoot_half <- surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  mutate(hindfoot_half = hindfoot_length / 2) %>% 
  filter(hindfoot_half < 30) %>% 
  select(species_id, hindfoot_half)

summary(surveys_hindfoot_half)

#### SPLIT-APPLY-COMBINE ####

#' split the data into groups (i.e., categorical variables)
#' apply some analysis to each group
#' combine the results

#' group_by()
#' summarize()

## By sex
surveys %>% 
  group_by(sex) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE))

## By multiple columns
surveys %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE)) %>%
  print(n = 30)

## Summarise multiple variables
surveys %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE), 
            min_weight = min(weight, na.rm = TRUE))

## Arrange results (smallest first)
surveys %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE), 
            min_weight = min(weight, na.rm = TRUE)) %>% 
  arrange(min_weight)

## Arrange by descending order
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(sex, species_id) %>% 
  summarise(mean_weight = mean(weight, na.rm = TRUE), 
            min_weight = min(weight, na.rm = TRUE)) %>% 
  arrange(desc(min_weight))

#### COUNT ####

## we often want to know the # of observations, per combination of factors
surveys %>% count(sex)
surveys %>% count(sex, sort = TRUE)

### Challenge 3
##  1. How many individuals were caught in each `plot_type` surveyed?

surveys %>% count(plot_type)

##  2. Use `group_by()` and `summarize()` to find the mean, min, and max
## hindfoot length for each species (using `species_id`). Also add the number of
## observations (hint: see `?n`).

surveys %>% 
  filter(!is.na(hindfoot_length)) %>% 
  group_by(species_id) %>% 
  summarise(mean = mean(hindfoot_length), 
            min = min(hindfoot_length), 
            max = max(hindfoot_length), 
            n_observed = n())

##  3. What was the heaviest animal measured in each year? Return the
##  columns `year`, `genus`, `species_id`, and `weight`.
surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(year) %>% 
  filter(weight == max(weight)) %>% 
  select(year, genus, species, weight) %>% 
  arrange(year)





