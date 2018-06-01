## Chloe May ##

#### attempts ####
kat_limp
quad_abun <- read_csv("quadrat_abundance.csv")

kat_limp <- quad_abun %>% select(Date, Katharina, Limpets)

#Converting data to long format
abund_long <-  gather(data = kat_limp, 
                     key = species, 
                     value = abundance, 
                     Katharina:Limpets, 
                     factor_key = T)
library(tidyr)
library(tidyverse)
library(dplyr)
library(ggplot2)
library("readr", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.3")


#### Read in data ####

quad_abund <- read_csv("quadrat_abundance.csv")
read.csv("quadrat_abundance.csv")


#### Convert to long data ####
kat_limp <- quad_abund %>% select(Date, Treatment, Area, Limpets, Katharina)

abund_long <-  gather(data = kat_limp, 
                      key = species, 
                      value = abundance, 
                      Katharina:Limpets, 
                      factor_key = T)


#### Adding in columns ####

abund_long <- mutate(abund_long, Year = as.character(Date))
abund_long <- abund_long %>% mutate(region = paste(Treatment, Area, sep = "_"))
abund_long <- abund_long %>% mutate(density = abundance * 10)



#### boxplot!!!! ####

abund_long %>% 
  ggplot(aes(x = region, y = density, fill = Year)) +
  geom_boxplot() +
  facet_wrap(~ species, scale = "free_y") +
  labs(y = "Density #/m^2", x = "Region", title = "Density of Grazers: Past and Present")


#### ratios ####
kl_ratio <- quad_abund %>% select(Date, Treatment, Area, Limpets, Katharina) %>% 
  mutate(region = paste(Treatment, Area, sep = "_"))

kl_ratio <- kl_ratio %>% mutate(Year = as.character(Date))

kl_ratio <- kl_ratio %>% 
  group_by(region) %>% 
  mutate(ratio = (Katharina + 1) / (Limpets + 1))

kl_ratio %>% 
  ggplot(aes(x = 1, y = ratio, fill = Year)) +
  geom_boxplot() + 
  facet_wrap(~region, scales = "free_y") +
  geom_hline(yintercept = 1) +
  labs(y = "Ratio Katharina:Limpets", title = "Katharina:Limpet According to Region and Year") +
  scale_fill_manual(values = c("lightseagreen", "goldenrod1")) +
  theme(axis.text.x = element_blank(), axis.title.x = element_blank())
ggsave("figures/final_prop_kat_limp.png",  height = 3.5, width = 5)
