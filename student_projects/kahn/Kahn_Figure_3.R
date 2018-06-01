histo_1982_combined %>% 
  ggplot(aes(basal_diameter, frequency)) +
  geom_bar(stat = "identity") +
  labs(x = "Basal Diameter (cm)", 
       y = "Frequency",
       title = "1982") +
  theme_bw(base_size = 16) +
  theme (panel.grid =  element_blank())

ggsave("figs_output/ basal_diameters_1982_histogram.png",
       height = 3.5,
       width = 4)



mean_diameters %>% 
  ggplot(aes(mean_cm)) +
  geom_histogram(binwidth = 0.2, color = "white", size = 0.5, boundary = 0) +
  labs(x = "Basal Diameter (cm)", 
       y = "Frequency",
       title = "2018") +
  theme_bw(base_size = 16) +
  theme (panel.grid =  element_blank())

ggsave("figs_output/ basal_diameters_2018_histogram.png",
       height = 3.5,
       width = 4)
