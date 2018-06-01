pop_density_areas %>% 
  ggplot(aes(tide_pool_area, anemone_count)) +
  geom_point() +
  scale_x_log10() +
  geom_smooth(method = "lm") +
  labs (x = "Tide Pool Area (m^2)", 
        y = "Number of Anemones") + 
  theme_bw(base_size = 16) +
  theme (panel.grid =  element_blank())

ggsave("figs_output/ pop_density_tidepool_area.png",
       height = 3.5,
       width = 4)