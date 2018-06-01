#### Limpet Katharina Denisty ####

quad_abund <- read.csv("quadrat_abundance.csv")

kat_limp <- quad_abund %>% select(Date, Treatment, Area, Limpets, Katharina)


kat_limp_long <-  gather(data = kat_limp, 
                     key = species, 
                     value = abundance, 
                     Katharina:Limpets, 
                     factor_key = T)

kat_limp_long <- mutate(kat_limp_long, Year = as.character(Date))

kat_limp_long %>% 
  ggplot(aes(x = region, y = abundance, fill = Year)) +
  geom_boxplot() +
  facet_wrap(~ species, scale = "free_y")

kl_ratio <- kat_limp_long %>% 
  mutate(ratio = Katharina / limpets)


#### column graph attempt ####
kat_limp_long <- kat_limp_long %>% mutate(ddensity = abundance*10)
kl_sum <- kat_limp_long %>% 
  group_by(region, species, Year_C) %>% 
  summarise(dense_mean = mean(ddensity, na.rm = T), 
            dense_sd = sd(ddensity, na.rm = T))


kl_sum <- kat_limp_long %>% 
  group_by(region, species, Year_C) %>% 
  summarise(mean = mean())

kat_limp_long %>% group_by(region, species, Year_C)
  ggplot(aes(x = region, y = mean(abundance), color = Year_C))+
    geom_col() +
    facet_wrap(Katharina~Limpet)

#### corrected and updated code ####

