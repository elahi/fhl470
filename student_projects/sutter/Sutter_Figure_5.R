library(tidyverse)
library(dplyr)

## Import necessary data
read_csv("quadrat_abundance.csv")
quad_abundance <- read.csv("quadrat_abundance.csv")


## Convert to long data 

algae <- select(quad_abundance,-Limpets, -A_m, -(Katharina:Mopalia))
abund_long <- gather(data = algae, 
                     key = species,
                     value = abundance,
                     S_sessilis:Phyllospadix,
                     factor_key = T)

## Sort data by upper and lower quadrats 

abund_long <- abund_long %>% 
  mutate(height_cat = ifelse(Tidal_height_quad_m > 0, "High", "Lower"),
         year_c = as.character(Date)) 


write.csv(abund_long, "abund_long.csv")
abund_long <- read.csv("abund_long.csv")

## Present data sorting

abund_low_present <- abund_long %>% 
  filter(height_cat == "Lower",
         Date == 2018) %>% 
  group_by(species) %>% 
  summarize(mean_low = mean(abundance),
            lower_deviation = sd(abundance))

abund_high_present <- abund_long %>% 
  filter(height_cat == "Upper",
         Date == 2018) %>% 
  group_by(species) %>% 
  summarize(mean_high = mean(abundance),
            upper_deviation = sd(abundance))

abund_present <- merge(abund_high_present, abund_low_present, by="species")

## Add Standard deviations
abund <- abund_present %>%
  group_by(species) %>% 
  mutate(Upper_deviation = sd(mean_high),
         Lower_deviation = sd(mean_low))

## Historic data sorting 

abund_low_historic <- abund_long %>% 
  filter(height_cat == "Lower",
         Date == 1979) %>% 
  group_by(species) %>% 
  summarize(mean_low = mean(abundance),
            lower_deviation = sd(abundance))

abund_high_historic <- abund_long %>% 
  filter(height_cat == "Upper",
         Date == 1979) %>% 
  group_by(species) %>% 
  summarize(mean_high = mean(abundance),
            upper_deviation = sd(abundance))

abund_historic <- merge(abund_high_historic, abund_low_historic, by="species")

##Output CSV for algal cover plot
write.csv(abund_historic, "historic2.csv")  
write.csv(abund_present, "present2.csv")  
abund_historic <- read.csv("historic11.csv")
abund_present <- read.csv("present11.csv")
alg_cover <- read.csv("algal_cover.csv")

##Make algal cover plots for past and present data

alg_cover %>% 
  group_by(species) %>% 
  ggplot(aes(species, mean_cover, fill = as.character(year))) +
  geom_errorbar(aes(ymin = mean_cover, ymax = mean_cover + deviation), 
                position = position_dodge(width = 0.9), 
                width = 0.25) +
  geom_col(position = position_dodge(width = 0.9),
           color = "black") +
  facet_wrap(~ treatment, ncol = 1) +
  labs(x = "Species", 
       y = "Percent Coverage", 
       title = "Algal Coverage in high and low intertidal",
       fill = "Year") +
  scale_fill_manual(values = c("springgreen4", "peru"))


ggsave("figures/final_algae_coverage.png", height = 7, width = 9)
