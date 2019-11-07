library(pacman)
p_load(gapminder)
library(tidyverse)
p_load(ggthemes)
p_load(countrycode)
p_load(maps)
p_load(mapproj)

glimpse(gapminder, width = 50)

gapminder_cleaned <- gapminder %>%
  filter(year == "2007") %>%
  mutate(
    pop2 = pop + 1,
    continent = case_when(
      continent == "Oceania" ~ "Asia",
      TRUE ~ as.character(continent)
    ) %>% as.factor %>%
      fct_relevel("Asia", "Americas", "Europe", "Africa")
  )

gapminder_plot <- ggplot(gapminder_cleaned, aes(x = gdpPercap, y = lifeExp)) +
  annotate("text", x = 4000, y = 45, hjust = 0.5,
           size = 85, color = "#999999",
           label = "2007", alpha = .3,
           family = "Roboto") +
  geom_point(aes(size = pop, color = continent)) +
  geom_point(aes(size = pop2), color = "black", shape = 21, alpha = 0.5) +
  scale_x_log10(breaks = c(500, 1000, 2000, 4000,
                           8000, 16000, 32000, 64000)) +
  scale_y_continuous(breaks = seq(0, 90, by = 10)) +
  scale_color_manual(values = c("#F15772", "#7EEB03",
                                "#FBE700", "#54D5E9")) +
  scale_size_continuous(range = c(1, 30)) +
  guides(size = FALSE, color = FALSE) +
  labs(
    x = "Income",
    y = "Life expectancy"
  ) +
  theme_minimal() +
  annotate("segment", x = 0, xend = 2014, y = 46.9, yend = 46.9, 
           color = "#606F7B", linetype = 2, size = .2) +
  annotate("segment", x = 2014, xend = 2014, y = 0, yend = 46.9,
           color = "#606F7B", linetype = 2, size = .2) +
  annotate("text", x = 28200, y = 2, 
           label = "per person (GDP/capita, PPP$ inflation-adjusted)",
           size = 2.8, color = "#999999") +
  annotate("text", x = 2304, y = 42, hjust = 0,
           size = 3.5,
           label = paste0("Nigeria had a life expectancy of\n",
                          "46.9 years and an annual income of",
                          "\n$2014 per year per person in 2007")) +
  theme(
    plot.margin = unit(rep(1, 4), "cm"),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_line(size = 0.2, 
                                    color = "#e5e5e5"),
    axis.title.y = element_text(margin = margin(r = 15), 
                                size = 11,
                                family = "Roboto Light"),
    axis.title.x = element_text(margin = margin(t = 15), 
                                size = 11,
                                family = "Roboto Light"),
    axis.text = element_text(family = "Roboto Light"),
    axis.line = element_line(color = "#999999", 
                             size = 0.2)
  ) +
  coord_cartesian(ylim = c(4.1, 86))

world <- map_data("world") %>%
  filter(region != "Antarctica") %>% 
  mutate(
    continent = countrycode(sourcevar = region,
                            origin = "country.name",
                            destination = "continent"),
    continent = case_when(
      continent == "Oceania" ~ "Asia",
      TRUE ~ as.character(continent)
    ) %>% as.factor %>% 
      fct_relevel("Asia", "Americas", "Europe", "Africa")
  ) %>% 
  drop_na(continent)

(continent_map <- ggplot(world) +
  geom_map(map = world,
           aes(long, lat, group = group, map_id = region, fill = continent)) +
  theme_map() +
  coord_map(xlim = c(-180, 180),
            ylim = c(-200, 200)) +
  scale_fill_manual(values = c("#F15772", "#7EEB03",
                               "#FBE700", "#54D5E9")) +
  guides(fill = F) +
  theme(
    plot.background = element_rect(color = "#b8c2cc", fill = NA)
  ))

gapminder_plot +
  annotation_custom(grob = ggplotGrob(continent_map), 
                    xmin = log10(800), 
                    xmax = log10(650000),
                    ymin = 5, 
                    ymax = 42) +
  labs(
    title = "Life Expectancy and Income in 2007",
    subtitle = paste0("In the following visualization you can see the ",
                      "relationship between income and life expectancy\n",
                      "among all countries in 2007. African countries are ",
                      "still lagging behind in terms of general\nlife expectancy. ",
                      "The European and American countries are the healthiest ",
                      "and richest countries\nin the world."),
    caption = "Esben Kran Christensen"
  ) + 
  theme(
    plot.margin = unit(rep(1, 4), "cm"),
    plot.title = element_text(color = "#22292F", hjust = 0,
                              margin = margin(b = 15),
                              size = 30,
                              face = "bold",
                              family = "Titillium Web"),
    plot.subtitle = element_text(color = "#3D4852", hjust = 0,
                                 margin = margin(b = 35),
                                 size = 17,
                                 lineheight = 1.1,
                                 family = "Titillium Web"),
    plot.caption = element_text(color = "#3d4852",
                                size = 10,
                                family = "Titillium web",
                                margin = margin(b = 35),
                                face = "italic")
  )

ggsave(width = 12, height = 10, "Adventures/gapminder.png")
