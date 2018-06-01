install.packages("tidyverse")
library(tidyr)
library(dplyr)
library(tidyverse)


read_csv("quadrat_abundance.csv")
sac_data <- read.csv("quadrat_abundance.csv")

#### Adding columns and converting to long format QUADRAT####
sac_data <- sac_data %>% select(Date, S_sessilis, Katharina, Limpets)
long_sac <- gather(data = sac_data,
                   key = species,
                   value = abundance,
                   Katharina:Limpets,
                   factor_key = T)

long_sac <- long_sac %>% mutate(year_c = as.character(Date), 
                                density = abundance * 10) %>% 
  select(year_c, S_sessilis, species, density)

#### scatterplot by QUADRAT ####

long_sac %>% group_by(year_c) %>% 
  ggplot(aes(x = S_sessilis, y = density, color = species)) +
  geom_point() +
  facet_wrap("year_c") +
  labs(x = "Percent coverage of S. sessilis in each quadrat", 
       y = "Density #/m^2", 
       title = "Grazer density against Kelp coverage")

#### Adding columns and converting to long format REGION####
reg_sac <- read.csv("quadrat_abundance.csv")
reg_sac <- reg_sac %>% select (Date, Treatment, Area, S_sessilis, Katharina, Limpets)
reg_sac <- gather(data = reg_sac,
                  key = species, value = abundance,
                  Katharina:Limpets,
                  factor_key = T)
reg_sac <- reg_sac %>% mutate(year_c = as.character(Date),
                              density = abundance * 10,
                              region = paste(Treatment, Area, sep = "_")) %>% 
  select(year_c, region, S_sessilis, species, density)

#### scatterplot by REGION ####

reg_sac <- reg_sac %>% group_by(year_c, region, species, S_sessilis) %>% 
  summarise(regmean = mean(density),
            regstd = sd(density))

reg_sac %>% group_by(year_c, region, species) %>% 
  ggplot(aes(x = S_sessilis, y = regmean, fill = species)) +
  geom_col() +
  facet_wrap("year_c")



#### tidal height ####

tide_sac <- read.csv("quadrat_abundance.csv")

tide_sac <- tide_sac %>% select(Date, S_sessilis, Katharina, Limpets, Tidal_height_quad_m)
tide_sac <- gather(data = tide_sac,
                   key = species,
                   value = abundance,
                   Katharina:Limpets,
                   factor_key = T)
tide_sac <- tide_sac %>% mutate(year_c = as.character(Date), 
                                density = abundance * 10) %>% 
  select(year_c, S_sessilis, species, density, Tidal_height_quad_m)

# How to categorize

tide_sac <- tide_sac %>% 
  mutate(thfactor = ifelse(Tidal_height_quad_m > 0, "upper", "lower"))

tide_sac %>% 
  filter(!is.na(thfactor)) %>% 
  ggplot(aes(x = S_sessilis, y = density, color = species)) +
  geom_point() +
  facet_wrap(~year_c) +
  labs(x = "Percent coverage of S. sessilis in each quadrat", 
       y = "Density #/m^2", 
       title = "Grazer density against Kelp coverage")


#### geom_smooth (just in case) ####
tide_sac <- tide_sac %>% 
  mutate(thfactor = ifelse(Tidal_height_quad_m > 0, "upper", "lower"))

tide_sac %>% 
  filter(!is.na(thfactor)) %>% 
  ggplot(aes(x = S_sessilis + 1, y = density + 1, color = species)) +
  geom_point() +
  facet_wrap(~year_c) +
  labs(x = "Percent coverage of S. sessilis", 
       y = "Density #/m^2", 
       title = "Grazer density against kelp coverage") +
  geom_smooth(method = "lm") +
  scale_y_log10() + 
  scale_x_log10() +
  scale_color_manual(values = c("seagreen4", "violetred3"))

ggsave("figures/limpkat_sac.png", width = 7, height = 5 )

write.csv(tide_sac, "tide_sac.csv")

