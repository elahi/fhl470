
library(tidyverse)

dat <- read_csv("data_ouput/surveys_long.csv")


#Create a collumn with the conversion of organsims per
# 1/4 m^2 to organisms per m^2
dat %>% 
  mutate(density_m2 = density_quarterm2*4)

#ccreates a new data frame which shows just
#organism, density_m2, and year surveyed
dat2 <- dat %>% 
  mutate(density_m2 = density_quarterm2*4) %>% 
  select(organism, density_m2, Year_surveyed)


#creating a table of species density organized by year
avg_density <- dat2 %>% 
  group_by(Year_surveyed, organism) %>% 
  summarize(avg_density_m2 = mean(density_m2, na.rm =TRUE))
  

mollusksPLUS <- c("Calliostoma_ligatum", "Crepidula","Diodora_aspera","Lirabuccinum_dirum","Littorina","Lottia_digitalis","Nucella_lamellosa","Nucella_ostrina","other_Lottia_and_Tectura","Katharina_tunicata","Tonicella")
molPLUS <- dat[dat$organism %in% mollusksPLUS,]

dat <- molPLUS
#Create a collumn with the conversion of organsims per
# 1/4 m^2 to organisms per m^2
dat %>% 
  mutate(density_m2 = density_quarterm2*4)

#ccreates a new data frame which shows just
#organism, density_m2, and year surveyed
dat2 <- dat %>% 
  mutate(density_m2 = density_quarterm2*4) %>% 
  select(organism, density_m2, Year_surveyed)

#creating a table of species density organized by year
avg_density <- dat2 %>% 
  group_by(Year_surveyed, organism) %>% 
  summarize(avg_density_m2 = mean(density_m2+1, na.rm =TRUE),
            sd_densitym2 = sd(density_m2, na.rm = TRUE))




#optimizing for projector presentation
avg_density %>% 
  ggplot( aes(x = organism, y = avg_density_m2, group = Year_surveyed, fill = as.factor(Year_surveyed)))+
  geom_col(width= 0.7,position = position_dodge(width = 0.7), color = "black") + 
  theme(axis.text.x = element_text(angle=45, hjust=1),panel.background = element_rect(fill = "white", color = "black")) + 
  labs(x= "Organism", y= "Average Density m^2", 
       title ="Mollusks per square meter of Dead Man's Bay: 1973 versus 2018")+
  geom_errorbar(aes(ymin= avg_density_m2 , ymax = avg_density_m2 + sd_densitym2 ), width = 0.25, size = 0.25, position = position_dodge(width = 0.7))+
  scale_fill_discrete(name = "Year")+
  scale_y_log10()



#optimizing for paper
avg_density %>% 
  ggplot( aes(x = organism, y = avg_density_m2, group = Year_surveyed, fill = as.factor(Year_surveyed)))+
  geom_col(width= 0.7,position = position_dodge(width = 0.7), color = "black") + 
  theme(axis.text.x = element_text(angle=45, hjust=1, face="italic"),panel.background = element_rect(fill = "white", color = "black")) + 
  labs(x= "", y= "Average Density, count per m^2", 
       title ="") +
  geom_errorbar(aes(ymin= avg_density_m2 , ymax = avg_density_m2 + sd_densitym2 ), width = 0.25, size = 0.25, position = position_dodge(width = 0.7))+
  scale_fill_discrete(name = "Year")+
  scale_x_discrete(labels= c("C. ligatum", "Crepidula", "D. aspera", "K. tunicata", "L. dirum", "Littorina", "L. digitalis", "N. lamellosa", "N. ostrina", "other limpets" ,"Tonicella"))+
  scale_y_log10()

ggsave("figures/bargraph_mollusk_density.png", height = 3.5, width = 5)

