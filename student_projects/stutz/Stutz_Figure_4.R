research_raw_data %>%
  select(species_id, size_cm) %>%
  filter(species_id == "leptasterias")

leptasterias_size <- research_raw_data %>%
  select(species_id, size_cm) %>%
  filter(species_id == "leptasterias")

write.csv(leptasterias_size, "data_output/leptasterias_size.csv")

leptasterias_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1)

leptasterias_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1) +
  labs(x = "Size (cm)",
       y = "Count",
       title = "Leptasterias") +
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6)) +
  theme_bw(base_size = 16) +
  theme(panel.grid = element_blank())

ggsave("figs/leptasterias_plot.png", height = 3.5, width = 4)

leptasterias_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1, color = "black", fill = "grey") +
  labs(x = "Size (cm)",
       y = "Count",
       title = "Leptasterias") +
  scale_x_continuous(breaks = seq(1, 7, by = 1)) +
  theme_bw(base_size = 16) +
  theme(panel.grid = element_blank())

ggsave("figs/leptasterias_plot.png", height = 3.5, width = 4)
