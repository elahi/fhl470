install.packages("tidyverse")
library(tidyverse)

library(dplyr)
library(tidyr)
library(colorspace)
read.csv("deadman_rawdata_8_05_21.csv")
surveys <- read.csv("deadman_rawdata_8_05_21.csv")

install.packages("tidyverse")
library(tidyverse)

## Crab data analysis ##
names(surveys)
surveys_crab <- surveys %>% select(Transect:Year_surveyed, Hemigrapsus_nudus, Pugettia_gracilis, 
                                       Pagarus)
surveys_long_crab <- gather(data = surveys_crab, key = species, value = abundance, 
                                Hemigrapsus_nudus, Pugettia_gracilis, Pagarus)

surveys_long_crab <- surveys_long_crab %>%
  mutate( density_m2 = abundance * 4)

surveys_summary_crab <- surveys_long_crab %>%
  mutate(Year_surveyed = as.character(Year_surveyed)) %>% 
  group_by(Year_surveyed, species) %>% 
  summarise(density_m2_mean = mean(density_m2), 
            density_m2_sd = sd(density_m2))

labels2 <- c(Hemigrapsus_nudus = "Hemigrapsus nudus", Pugettia_gracilis = "Pugettia gracilis", Pagarus = "Pagarus spp.") 

surveys_summary_crab %>%
  ggplot(aes(x = Year_surveyed, y = density_m2_mean, fill = Year_surveyed)) +
  geom_errorbar(aes(ymin = density_m2_mean - density_m2_sd, 
                    ymax = density_m2_mean + density_m2_sd, width = 0.2)) +
  geom_col() +
  labs(x = "", y = "Mean Population Density / Meter Squared", 
       title = "                Observed Crab Population Density") +
  scale_fill_discrete(name = "Year Surveyed") +
  theme_dark() +
  facet_wrap(~species, labeller = labeller(species = labels2))

