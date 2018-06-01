## Chloe May ##

install.packages("tidyverse")
library(tidyverse)
library(dplyr)
library(tidyr)

BS_raw_data <- read_csv("katharina_body_size_nearest_cm.csv")

class(BS_raw_data)
year_length <- select(BS_raw_data, Year, Body_length_cm)


year_length_count <- group_by(year_length, Year) %>%
  count(Body_length_cm) %>% ungroup()

year_length_count <- year_length_count %>% group_by(Year) %>% 
  mutate(N = sum(n), 
         prop = n / N,
         Year. = as.character(Year))


ggplot(year_length_count,
       mapping = aes(x = Body_length_cm, y = prop, color = Year_C)) +
  geom_point() + geom_line() +
  scale_color_manual(values = c("seagreen4", "violetred3")) +
  labs(x = "Katharina body length cm", y = "Proportional Frequency", 
       title = "Proportional Frequency of Katharina Body Size" ) +
  scale_x_continuous(breaks = seq(1, 9, by = 1))

ggsave("figures/prop_BL.png", height = 3.5, width = 5)


