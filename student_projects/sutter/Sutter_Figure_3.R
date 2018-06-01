## mean limpet to kath ratio plotted by site and year 

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

kl_ratio <- quad_abund %>% select(Date, Treatment, Limpets, Katharina)  
##%>% mutate(region = paste(Treatment, Area, sep = "_")) 

kl_ratio <- kl_ratio %>% mutate(Year = as.character(Date))

kl_ratio <- kl_ratio %>% 
  mutate(ratio = (Katharina + 1) / (Limpets + 1)) 

### boxplot - ratio of limpets to katharina 
kl_ratio %>% 
  ggplot(aes(x = 1, y = ratio, fill = Year)) +
  geom_boxplot()  +
  facet_wrap(~Treatment, scales = "free_y") +
  geom_hline(yintercept = 1) +
  labs(x ="Grazers", y ="Density Ratio", title = "Ratio of Katharina to Limpets by Area" ) +
  scale_fill_manual(values = c("lightseagreen", "goldenrod1")) +
  theme(axis.text.x = element_blank(), axis.title.x = element_blank())

ggsave("figures/final_katlimp_rat.png", width = 5, height = 5)