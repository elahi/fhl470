#################################################
# Author: Robin Elahi
# Date: 180412
# FHL470
# Explore student database
#################################################

##### PACKAGES, DATA #####

## Install tidyverse
install.packages("tidyverse")

## Load tidyverse
library(tidyverse)

## Load FHL class reports database
dat <- read_csv("databases/database_fhl_nolan_180123_1949-1969_students.csv")
names(dat)

## Note that there are two columns that do not have names
## All columns should have names (make it a rectangle!)
names(dat)[7] <- "Year"

## Reorder the dataframe
dat <- dat %>% arrange(ID)
head(dat)

## Remove 1969
dat <- dat %>% filter(Year < 1969)

##### EXPLORE THE DATABASE #####

## How many entries per group?
dat %>% count(GroupNames) # Note lack of consistency

## How many ecological studies?
dat %>% count(Ecological)

## How many repeatable studies?
dat %>% count(Repeatable)

## How many intertidal studies?
dat %>% count(Intertidal)

## Filter for the relevant studies
dat2 <- dat %>% 
  filter(Ecological > 0 & Repeatable > 0 & Intertidal > 0)

## Save this file for the students
write.csv(dat2, "output/database_fhl_nolan_180123_1949-1968_relevant.csv")


