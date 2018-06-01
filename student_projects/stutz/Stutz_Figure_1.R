library(tidyverse)
research_raw_data <- read_csv("data/research_raw_data.csv")

research_raw_data %>%
  select(site, species_id, size_cm)
research_raw_data %>% 
  count(species_id, site, transect)
data_count <- research_raw_data %>% 
  count(species_id, site, transect)
data_count <- data_count %>%
  mutate(era = "present")
write.csv(data_count, "data_output/seastar_count.csv")

capFirst <- function(s) {
  paste(toupper(substring(s, 1, 1)), substring(s, 2), sep = "")
}
#### load edited data file ####
star_count <- read_csv("data_output/seastar_count_edit.csv")

star_count <- star_count %>%
  mutate(transect = as.character(transect),
         dens_m2 = count / area_m2)

star_count %>%
  filter(species_id == "pisaster" | species_id == "henricia") %>%
  ggplot(aes(x = transect, y = count, color = era)) +
  geom_point() +
  facet_wrap(~species_id) 
  
star_count %>%
  filter(species_id == "pisaster" | species_id == "henricia") %>%
  ggplot(aes(x = site, y = count, color = era)) +
  geom_point() +
  facet_wrap(~species_id) 

star_count %>%
  filter(species_id == "pisaster" | species_id == "henricia") %>%
  ggplot(aes(x = site, y = count, color = era)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.5) ) +
  facet_wrap(~species_id) 
 
capFirst("species")

star_count <- star_count %>%
  mutate(genus = capFirst(species_id))

star_count %>%
  filter(genus == "Pisaster" | genus == "Henricia") %>%
  ggplot(aes(x = site, y = count, color = era)) +
  geom_point() +
  facet_wrap(~genus) +
  labs(x = "Site", y = "Count") +
  theme_bw(base_size = 14) +
  theme(panel.grid = element_blank())

ggsave("figs/historical_current_plot.png",
       height = 3.5,
       width = 5)

#### Mean and Standard Deviation ####
research_raw_data %>% 
  group_by(species_id) %>% 
  summarise(mean_size = mean(size_cm, na.rm = TRUE), 
            sd_size = sd(size_cm, na.rm = TRUE))

star_count_density <- star_count %>%
  group_by(species_id, era) %>%
  summarise(mean_density = mean(dens_m2),
            sd_density = sd(dens_m2))

write.csv(star_count_density, "data_output/seastar_density.csv")


#### Species Per Site ####

research_raw_data%>%
  filter(species_id == "henricia") +
  group_by(species_id, site)

henricia_count <- research_raw_data %>%
  select(species_id, site) %>%
  filter(species_id == "henricia")

#### Counts ####
henricia_count %>% 
  group_by(site)
research_raw_data %>%
  count(species_id)
