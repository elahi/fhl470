pop_density_summary %>% 
  ggplot(aes(site, mean_density, color = elevation)) +
  geom_errorbar(aes(ymin = mean_density - sd_density, 
                    ymax = mean_density + sd_density),
                position = position_dodge(width = 0.5),
                width = 0.2) +
  geom_point(position = position_dodge(width = 0.5)) +
  labs (x = "Site", 
        y = "Mean Population Density") + 
  theme_bw(base_size = 16) +
  theme (panel.grid =  element_blank())


ggsave("figs_output/pop_density_sites.png",
       height = 3.5,
       width = 4)