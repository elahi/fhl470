library(dplyr)
library(tidyr)
library(colorspace)
read.csv("deadman_rawdata_8_05_21.csv")
surveys <- read.csv("deadman_rawdata_8_05_21.csv")

install.packages("tidyverse")
library(tidyverse)

## Barnacle data analysis ##

names(surveys)
surveys_barnacle <- surveys %>% select(Transect:Year_surveyed, Balanus_glandula, 
                                       Semibalanus_cariosus)
surveys_long_barnacle <- gather(data = surveys_barnacle, key = species, value = abundance, 
                                Balanus_glandula, Semibalanus_cariosus)

surveys_long_barnacle <- surveys_long_barnacle %>%
  mutate( density_m2 = abundance * 4)

surveys_summary_barnacle <- surveys_long_barnacle %>%
  mutate(Year_surveyed = as.character(Year_surveyed)) %>% 
  group_by(Year_surveyed, species) %>% 
  summarise(density_m2_mean = mean(density_m2), 
            density_m2_sd = sd(density_m2))

labels <- c(Balanus_glandula = "Balanus glandula", Semibalanus_cariosus = "Semibalanus cariosus")            

surveys_summary_barnacle %>%
  ggplot(aes(x = Year_surveyed, y = density_m2_mean, fill = Year_surveyed)) +
  geom_errorbar(aes(ymin = density_m2_mean - density_m2_sd, 
                    ymax = density_m2_mean + density_m2_sd, width = 0.2)) +
  geom_col() +
  labs(x = "", y = "Mean Population Density / Meter Squared", 
       title = "               Observed Barnacle Population Density") +
  scale_fill_discrete(name = "Year Surveyed") +
  theme_dark() +
  facet_wrap(~species, labeller = labeller(species = labels))
