## Kia Sutter ##
## 5/20/2018

install.packages("tidyverse")
install.packages("ggplot2")
library(tidyverse)
library(dplyr)
library(tidyr)
read_csv("quadrat_abundance.csv")

read_csv("Katharina_body_size_nearest_cm.csv")

body_size <- read.csv("Katharina_body_size_nearest_cm.csv")

class(body_size)

read_csv("Katharina_body_size_nearest_cm.csv")
body_size <- read.csv("Katharina_body_size_nearest_cm.csv")

options(max.print = 1000000)
year_length <- select(body_size, Year, Body_length_cm)


year_length_freq <- year_length %>% 
  mutate(freq = count(Body_length_cm))

year_length_count <- year_length %>% count(Body_length_cm)
year_length_count %>% mutate(freq = n)

filter(year_length, Year > 1979)

year_length_count <- group_by(year_length, Year) %>% 
  count(Body_length_cm) %>% ungroup()

year_length_count <- year_length_count %>% group_by(Year) %>% 
  mutate(N = sum(n),
         prop = n / N,
         Year.= as.character(Year))

ggplot(year_length_count, 
       aes(Body_length_cm, prop, color = Year.)) +
  geom_point() + geom_line() +
  labs(x = "Katharina Body Length in cm", y = "Proportional Frequency", 
       title = "Proportional Frequency of Katharina Body Size") +
  scale_color_manual(values = c("seagreen4", "violetred3")) +
  scale_x_continuous(breaks = seq(1, 9, by = 1))

ggsave("figures/prop_BL.png", height = 3.5, width = 5)
