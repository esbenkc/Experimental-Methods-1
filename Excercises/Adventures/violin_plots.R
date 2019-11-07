library(pacman)
p_load(tidyverse)
p_load(lubridate)
p_load(scales)


lifts <- read_csv(paste0("https://raw.githubusercontent.com/",
                         "rfordatascience/tidytuesday/master/data/2019/2019-10-08/ipf_lifts.csv")) 
glimpse(lifts, width = 50)

lifts <- lifts %>% 
  mutate(
    age_class = age_class %>% as.factor
  ) %>% 
  filter(!age_class == "5-12") %>% 
  drop_na(age_class) 

lifts %>% 
  ggplot(aes(x = age_class, y = best3squat_kg)) +
  geom_jitter(alpha = .05) +
  geom_violin(alpha = .9, draw_quantiles = c(0.5))

p_load(ggbeeswarm)

lifts %>% 
  ggplot(aes(x = age_class, y = best3squat_kg)) +
  geom_quasirandom(alpha = 0.05, width = 0.2, color = "#eba487") +
  stat_summary(fun.y = "median", geom = "point", size = 2, color = "#abdcf1") +
  stat_summary(fun.y = "median", geom = "line", aes(group = 1),
               size = 1.1, color = "#abdcf1") +
  scale_y_continuous(limits = c(0, 500),
                     expand = c(0, 0),
                     labels = scales::unit_format(unit = "kg")) +
  labs(
    title = "How age affects the maximum weight\nthat can be lifted with squats",
    subtitle = paste0("Most professional athletes take part in competitions",
                      " when they are between 20 and 34.\nThe ",
                      "highest weights are achieved by professional ",
                      "athletes between the ages of 20\nand 34. After ",
                      "that the weight decreases steadily."),
    x = "age",
    y = "kg lifted",
    caption = "Esben Kran Christensen"
  ) +
  theme_minimal() +
  theme(
    text = element_text(family = "Roboto"),
    plot.margin = unit(rep(1.2, 4), "cm"),
    plot.title = element_text(size = 19, 
                              face = "bold",
                              margin = margin(b = 8),
                              color = "#f2f3f5"),
    plot.background = element_rect(fill = "#1a1c2e"),
    plot.subtitle = element_text(size = 14, 
                                 lineheight = 1.1,
                                 color = "#e6e7eb",
                                 margin = margin(b = 45)),
    plot.caption = element_text(size = 12,
                                color = "#878890",
                                face = "italic"),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    panel.grid.major.y = element_line(color = "#21243a"),
    panel.grid.major.x = element_line(color = "#21243a"),
    axis.text = element_text(color = "#e6e7eb", size = 10),
    axis.text.x = element_text(margin = margin(t = 5)),
    axis.text.y = element_text(margin = margin(r = 5)),
    axis.title = element_text(size = 14, color = "#e6e7eb"),line = 
    axis.title.y = element_text(margin = margin(r = 20),
                                hjust = 1),
    axis.ticks = element_line(color = "#c2c3cf"),
    axis.title.x = element_text(margin = margin(t = 15),
                                hjust = 1),
    axis.line = element_line(color = "#878890")
  )

ggsave(width = 13, height = 8, "Adventures/violin_plots.png")
