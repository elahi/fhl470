
library(ggmap)
library(tidyverse)

dat <- read.csv("student_projects/fhl470_project_sites.csv")

#### MAP ####

map_theme <- theme_minimal() + 
  theme(axis.title = element_blank(), 
        axis.text = element_blank())

map_center <- c(-123.055, 48.510) # SJI center

## Stamen maps
map_sji <- ggmap(get_map(location = map_center, zoom = 12, 
                         maptype = "toner", source = "stamen"))

## Google maps
map_sji <- ggmap(get_map(location = map_center, zoom = 12, 
                         maptype = "terrain", source = "google"))

map_sji + 
  geom_point(data = dat, aes(longitude, latitude), 
             size = 4, alpha = 0.75) + 
  map_theme

ggsave("fig_output/fhl470_project_sites_map.png", height = 5, width = 5)

#### TIMELINE ####
library(timeline)
library(lubridate)
library(viridis)
data(ww2)
ww2
ww2.events

?timeline
timeline(ww2, ww2.events, event.spots=2, event.label='', event.above=FALSE)

## For bounded events (i.e., start and end date)
#' Person: text string
#' Group: grouping factor
#' StartDate
#' EndDate

## For instantaneous events (i.e., only a start date)
#' Event: text string
#' Date: yyyy-mm-dd format
#' Grouping factor(s)

dat <- dat %>% 
  mutate(StartDate = ymd(paste(year_past, "01", "01", sep = "-")), 
         EndDate = ymd(paste(year_present, "01", "01", sep = "-")))

timeline(df = dat, label.col = "site", 
         start.col = "StartDate", end.col = "EndDate") + 
  theme_classic(base_size = 16) + 
  theme(legend.position = "none", 
        axis.text.y = element_blank(), 
        axis.line.y = element_blank(), 
        axis.ticks.y = element_blank()) 

ggsave("fig_output/fhl470_project_sites_timeline.png", height = 3.5, width = 7)
