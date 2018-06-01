### Saccharina coverage vs limp and kat abundance
install.packages("tidyverse")
library(tidyverse)
library(tidyr)
library(dplyr)
read_csv("quadrat_abundance.csv")

sac_data <- read.csv("quadrat_abundance.csv")

sac_data <- sac_data %>% select(Date, S_sessilis, Katharina, Limpets)

long_sac <- gather(data = sac_data,
                   key = Species,
                   value = abundance,
                   Katharina:Limpets,
                   factor_key = TRUE)

long_sac <- long_sac %>% mutate(Year = as.character(Date),
                                density = abundance * 10)
long_sac <- long_sac %>% select(Year, density, S_sessilis, Species)


## scatterplot - kat limp density vs s. sessilis 

long_sac %>% group_by(Year) %>% 
  ggplot(aes(S_sessilis, density, color = Species)) +
  geom_point() +
  facet_wrap("year_c") +
  labs(x = "Percent Cover S. sessilis per quadrat", y = "Density per m^2 of Katharina and Limpets")

## scatterplot by region

read_csv("quadrat_abundance.csv")

reg_sac <- read.csv("quadrat_abundance.csv")

reg_sac <- reg_sac %>% select(Date, Treatment, Area, S_sessilis, Katharina, Limpets)

reg_sac <- gather(data = reg_sac,
                   key = Species,
                   value = abundance,
                   Katharina:Limpets,
                   factor_key = TRUE)

 reg_sac<- reg_sac %>% mutate(Year = as.character(Date),
                                density = abundance * 10,
                              region = paste(Treatment, Area, sep = "_"))

reg_sac <- reg_sac %>% select(Year, density, S_sessilis, Species, region)

reg_sac <- reg_sac %>% group_by(Year, region, Species, S_sessilis) %>% 
  summarise(regmean = mean(density), 
            regstd = sd(density))
  
reg_sac %>% group_by(region) %>% 
  ggplot(aes(S_sessilis, regmean, color = Species)) +
  geom_col() +
  facet_wrap("Year")
### Tidal heights to saccharina

read_csv("quadrat_abundance.csv")


tide_sac <- read.csv("quadrat_abundance.csv")

tide_sac <- tide_sac %>% select(Date, S_sessilis, Katharina, Limpets, Tidal_height_quad_m)

long_tide <- gather(data = tide_sac,
                   key = Species,
                   value = abundance,
                   Katharina:Limpets,
                   factor_key = TRUE)

long_tide <- long_tide %>% mutate(Year = as.character(Date),
                                density = abundance * 10)
long_tide <- long_tide %>% select(Year, density, S_sessilis, species, Tidal_height_quad_m)

long_tide <- long_tide %>% 
  mutate(thfactor = ifelse(Tidal_height_quad_m > 0, "upper", "lower"))

long_tide %>% 
  filter(!is.na(thfactor)) %>% 
  ggplot(aes(S_sessilis +1, density +1, color = Species)) +
  geom_point() +
  facet_wrap(~Year) + 
  labs(x = "Percent Cover S. sessilis", 
       y = "Density per m^2",
       title = "Grazer density against kelp coverage") +
  geom_smooth(method = "lm") +
  scale_y_log10() +
  scale_x_log10() +
  scale_color_manual(values = c("seagreen4", "violetred3"))


ggsave("figures/limpkat_sac.png", width = 7, height = 5)


