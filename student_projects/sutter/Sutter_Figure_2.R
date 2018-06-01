### limpet katharina density

read_csv("quad_abund_TA.csv")
quad_abund <- read.csv("quad_abund_TA.csv")

library(tidyr)
library(tidyverse)
library(dplyr)
library(ggplot2)
## converting wide to long 

kat_limp <- quad_abund %>% select(Date, Treatment, Limpets, Katharina)

abund_long <- gather(data = kat_limp,
                     key = species,
                     value = abundance,
                     Katharina:Limpets,
                     factor_key = TRUE)

## adding in year as character, and region column (treatment + area)

abund_long <- mutate(abund_long, Year = as.character(Date))

## abund_long <- abund_long %>%  mutate(region = paste(Treatment, sep = "_"))


## boxplot! abundance by region and species
abund_long %>% 
  mutate(density = abundance * 10) %>% 
  ggplot(aes(x = Treatment, y = density, fill = Year)) +
  geom_boxplot() +
  facet_wrap(~ species, scale = "free_y") +
  labs(y = "Density #/m^2", x = "Area", 
       title = "Density of Grazers: Past and Present") +
  scale_fill_manual(values = c("lightseagreen", "goldenrod1"))

ggsave("figures/final_grazer_density.png", width = 5, height = 5)


