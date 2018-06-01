install.packages("tidyverse")
library(tidyverse)

library(dplyr)
library(tidyr)
library(colorspace)

## Temperature Data 1965 to 2016

read.csv("temp_data_65to16.csv")
tempdata <- read.csv("temp_data_65to16.csv")

tempdata %>% 
  ggplot(aes(x = DATE, y = TMAX)) +
  geom_point() +
  geom_smooth(method = "lm") +
  theme_gray() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs( x = "Year", y = "Max Temperature (Fahrenheit)", 
        title = "                      Temperature Readings from Olga, Orcas Island")
