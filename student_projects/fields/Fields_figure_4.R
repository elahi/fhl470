library(tidyverse)

dat <- read_csv("data_ouput/surveys_long.csv")

mollusksPLUS <- c("Calliostoma_ligatum", "Crepidula","Diodora_aspera","Lirabuccinum_dirum","Littorina","Lottia_digitalis","Nucella_lamellosa","Nucella_ostrina","other_Lottia_and_Tectura","Archidoris_montereyensis","Katharina_tunicata","Tonicella")
molPLUS <- dat[dat$organism %in% mollusksPLUS,]
dat <- molPLUS



dat <- dat %>%
  group_by(Year_surveyed, Quadrat, Transect) %>% 
  mutate(N = sum(density_quarterm2, na.rm = TRUE), 
         relative_abundance = density_quarterm2/N) %>% ungroup()%>% 
  mutate(relative_abundance = ifelse(relative_abundance>0,
                                             relative_abundance,0)) %>% 
  mutate(relative_abundance = ifelse(is.na(relative_abundance),
                                     0,relative_abundance))

avg_rel_abundances <- dat %>%
  group_by(organism, Year_surveyed) %>% 
  summarise(average_relative_abundance = mean(relative_abundance)) 


avg_rel_abundances$Year_surveyed <- as.character(avg_rel_abundances$Year_surveyed)


avg_rel_abundances_wideyear <- avg_rel_abundances %>% spread(key = Year_surveyed, value = average_relative_abundance)

organism_label <- c("D. montereyensis","C. ligatum","Crepidula","D. aspera","K. tunicata","L. dirum","Littorina","L. digitalis","N. lamellosa","N.ostrina","other limpets","Tonicella")

ggplot(data = avg_rel_abundances_wideyear, aes(x= avg_rel_abundances_wideyear$`1973`, y= avg_rel_abundances_wideyear$`2018`)) + geom_point() + geom_abline(mapping = NULL, data= NULL,slope= 1,intercept = 0, linetype="dashed") +
  geom_text(aes(label=organism_label), size=4)+
  labs(title = "Historical Relative Abundance vs Contemporary Relative Abundance") +
  ylab("Relative Abundance, 2018")+
  xlab("Relative Abundance, 1973")



ggplot(data = avg_rel_abundances_wideyear, aes(x= avg_rel_abundances_wideyear$`1973`, y= avg_rel_abundances_wideyear$`2018`,  color = organism)) + geom_point(size=4) + geom_abline(mapping = NULL, data= NULL,slope= 1,intercept = 0, linetype="dashed") +
  ylab("Relative Abundance, 2018")+
  xlab("Relative Abundance, 1973")+ 
  annotate(geom = "text", x = 0.29, y = 0.36, label ="Littorina", fontface="italic", size =5 ) +
  annotate(geom ="text", x = 0.105, y = 0.36, label = "other limpets", size = 5) +
  annotate(geom = "text", x = 0.135, y = 0.04, label = "K. tunicata", fontface="italic", size=5) +
  theme(legend.text=element_text(size=15),axis.title.x=element_text(size=20), axis.title.y =element_text(size = 20), panel.background = element_rect(fill = "white", color = "black")) +scale_color_hue(labels = organism_label)

ggsave("figures/historical_vs_contemporary_relative_abundance_forppt.png", height = 6, width = 9)



ggplot(data = avg_rel_abundances_wideyear, aes(x= avg_rel_abundances_wideyear$`1973`, y= avg_rel_abundances_wideyear$`2018`,  color = organism)) + geom_point(size=3) + geom_abline(mapping = NULL, data= NULL,slope= 1,intercept = 0, linetype="dashed") +
  ylab("Relative Abundance, 2018")+
  xlab("Relative Abundance, 1973")+ 
  annotate(geom = "text", x = 0.27, y = 0.35, label ="Littorina", fontface="italic") +
  annotate(geom ="text", x = 0.1, y = 0.35, label = "other limpets") +
  annotate(geom = "text", x = 0.135, y = 0.04, label = "K. tunicata", fontface="italic") +
  theme(legend.position ="none", panel.background = element_rect(fill = "white", color = "black")) 

ggsave("figures/historical_vs_contemporary_relative_abundance.png", height = 3.5, width = 3.5)



