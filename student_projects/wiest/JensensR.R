library(tidyverse)

dat <-read_csv("Data/Dock_Communities_2018.3.csv")


theme_set(theme_bw(base_size = 16)+
            theme(panel.grid = element_blank()))

names(dat)[1]

#### Create long dataset####
dat_long<- dat %>%
  gather(key = species, value= percent_cover, brown_fillamentous_algae:Haliclona_sp)
names(dat_long)
#lets reorder the species by percent_cover#
dat_long<-dat_long%>%
  mutate(species=reorder(species,-percent_cover, FUN=median))

dat_long<-dat_long %>%
  mutate(year=as.character(year))


#### Box Plot####


dat_long%>%
  ggplot(aes(species, percent_cover, fill=year))+
  geom_boxplot()+
  coord_flip()+
  labs(x="", y= "Percent Cover")+
  theme(legend.position = "bottom")

ggsave("Fig/jensens_boxplot_1.png", height= 8, width = 8)


dat_long%>%
  ggplot(aes(species, percent_cover, fill=year))+
  geom_boxplot()+
  coord_flip()+
  labs(x="", y= "Percent Cover")+
  theme(legend.position = "bottom")+
  facet_wrap(~Covered_uncovered)


ggsave("Fig/Jensens_coveredun.png", height= 8, width = 9)






#### Create Summary Stats####
 dat_summary<-dat_long %>%
   group_by(species, Covered_uncovered,year) %>%
   summarise(mean_percent_cover=mean(percent_cover),
             sd_cover=sd(percent_cover))
 

dat_summary_wide<-dat_summary%>%
  select(-sd_cover)%>%
  spread(key = year, value= mean_percent_cover)
 
 

 write.csv(dat_summary_wide, "data_output/jensens_mean_by_year.csv")
 
 
 
 write.csv(dat_summary_wide,"data_output/jensens_mean_covered ")
 
 
 
 
 
 
 
 
 
 
 