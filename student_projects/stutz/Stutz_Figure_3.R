research_raw_data %>%
  select(species_id, size_cm) %>%
  filter(species_id == "henricia")

henricia_size <- research_raw_data %>%
  select(species_id, size_cm) %>%
  filter(species_id == "henricia")

write.csv(henricia_size, "data_output/henricia_size.csv")

henricia_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1)



henricia_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1, color = "black", fill = "grey") +
  labs(x = "Size (cm)",
       y = "Count",
       title = "Henricia") +
  scale_x_continuous(breaks = seq(1, 7, by = 1)) +
  theme_bw(base_size = 16) +
  theme(panel.grid = element_blank())

ggsave("figs/henricia_plot.png", height = 3.5, width = 4)
