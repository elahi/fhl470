library(tidyverse)
##air temperature from Orcas Island
dat <- read_csv("data/yearly_temps_olga.csv")


ggplot(data = dat, aes( x = DATE, y = ((TMAX - 32)*5/9))) + 
  geom_point()+
  geom_smooth(method = "lm")+
  theme(axis.text.x = element_text(angle = 0, hjust = 1), panel.background = element_rect(fill = "white", color = "black"))+
  labs(x = "Year", y = "Maximum Air Temperature, degrees Celsius")

ggsave("figures/Orcas_temperature_plot.png", height = 3.5, width = 3.5)
#
title = "Maximum Air Temperature on Orcas Island  (Yearly Average)"