low_high_basal_dia_CP_historical %>% 
  ggplot(aes(year_c, mean_diameter, color = elevation))+ 
  geom_point(position = position_dodge(width = 0.5)) + 
  geom_errorbar(aes(ymin = sd_minus, 
                    ymax = sd_plus),position = position_dodge(width = 0.5)) +
  labs (x = "Year", 
        y = "Mean Basal Diameter (cm)") + 
  theme_bw(base_size = 16) +
  theme (panel.grid =  element_blank())