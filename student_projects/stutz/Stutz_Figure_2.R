star_count %>%
  filter(species_id == "pisaster") %>%
  ggplot(aes(x = size_cm, y = count)) +
  geom_point()

research_raw_data %>%
  select(species_id, size_cm) %>%
  filter(species_id == "pisaster")

pisaster_size <- research_raw_data %>%
  select(species_id, size_cm) %>%
  filter(species_id == "pisaster")

pisaster_size %>%
  ggplot(aes(x = size_cm, y = count)) +
  geom_bar()

write.csv(pisaster_size, "data_output/pisaster_size.csv")

pisaster_size_edited <- read_csv("data_output/pisaster_size_edited.csv")

pisaster_size_edited %>%
  ggplot(aes(x = size_cm, y = count)) +
  geom_col()

pisaster_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1)

pisaster_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1) +
  labs(x = "Size (cm)",
       y = "Count",
       title = "Pisaster")

pisaster_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1) +
  labs(x = "Size (cm)",
       y = "Count",
       title = "Pisaster") +
  scale_x_continuous(breaks = c(10, 12, 14, 16, 18, 20)) 

pisaster_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1) +
  labs(x = "Size (cm)",
       y = "Count",
       title = "Pisaster") +
  scale_x_continuous(breaks = c(10, 12, 14, 16, 18, 20)) +
  theme_bw(base_size = 16) +
  theme(panel.grid = element_blank())

pisaster_size %>%
  ggplot(aes(x = size_cm)) +
  geom_histogram(binwidth = 1, color = "black", fill = "grey") +
  labs(x = "Size (cm)",
       y = "Count",
       title = "Pisaster") +
  scale_x_continuous(breaks = seq(10, 20, by = 2)) +
  theme_bw(base_size = 16) +
  theme(panel.grid = element_blank())

ggsave("figs/pisaster_plot.png", height = 3.5, width = 4)







