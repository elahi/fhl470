##' Robin Elahi
##' 31 Oct 2018

library(tidyverse)
library(dplyr)
library(tidyr)

BS_raw_data <- read_csv("student_projects/may_wsn/Katharina_body_size_nearest_cm.csv")

class(BS_raw_data)
year_length <- select(BS_raw_data, Year, Body_length_cm)

year_length_count <- group_by(year_length, Year) %>%
  count(Body_length_cm) %>% ungroup()

year_length_count <- year_length_count %>% 
  group_by(Year) %>% 
  mutate(N = sum(n), 
         prop = n / N) %>% 
  ungroup() %>% 
  mutate(Year = as.character(Year))
         
## Robin's edits
theme_set(theme_bw(base_size = 18) + 
            theme(panel.grid = element_blank()))
ggplot(year_length_count,
       mapping = aes(x = Body_length_cm, y = prop, color = Year)) +
  geom_point(size = 2) + 
  geom_line(size = 1) +
  scale_color_manual(values = c("green", "blue")) +
  labs(x = "Body length (cm)", y = "Proportional Frequency" ) +
  scale_x_continuous(breaks = seq(1,9, by = 1)) + 
  theme(legend.position = c(0.05, 0.95), 
        legend.justification = c(0.05, 0.95))

ggsave("student_projects/may_wsn/katharina_histogram.pdf", height = 6, width = 6)
