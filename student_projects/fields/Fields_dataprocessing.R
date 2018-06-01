library(tidyverse)

surveys <- read_csv("data/Fields_deadman_rawdata_historicalandcontemporary_2018_05_20.csv")

surveys_long <-  surveys %>% gather(key = organism, value = density_quarterm2, -Month_surveyed, -Day_surveyed, -Year_surveyed, -Transect, -Quadrat, -Distance_on_transect)


write_csv(surveys_long, path = "data_ouput/surveys_long.csv")



surveys_long_2018 <- surveys_long %>% 
  filter(Year_surveyed==2018) %>% 
  select(organism, density_quarterm2)

surveys_long_1973 <- surveys_long %>%
  filter(Year_surveyed==1973) %>% 
  select(organism, density_quarterm2)

write_csv(surveys_long_2018, path = "data_output/surveys_long_2018.csv")

write.csv(surveys_long_1973, "data_output/surveys_long_1973.csv")

