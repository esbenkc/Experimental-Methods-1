library(pacman)
library(tidyverse)
p_load(ggbeeswarm)
p_load(gridExtra)


df <- read.csv("../PsychoPy/logfiles/readingP2_2_Bonyby.csv")

wordlen = vector()

for (i in df$Word){
  wordlen <- c(wordlen, nchar(i))
}
  
df <- df %>% mutate(Word_Length = wordlen)
View(df)

ggplot(df, aes(x = df$Reaction.time, y = df$Word_Length)) +
  geom_point(alpha = 0.05, color = "#eba487") +
  stat_summary(fun.y = "median", geom = "point", size = 2, color = "#abdcf1") +
  stat_summary(fun.y = "median", geom = "line", aes(group = 1),
               size = 1.1, color = "#abdcf1") +
  labs(
    title = "How word length affects reading times",
    subtitle = paste0("Most professional athletes take part in competitions",
                      " when they are between 20 and 34.\nThe ",
                      "highest weights are achieved by professional ",
                      "athletes between the ages of 20\nand 34. After ",
                      "that the weight decreases steadily."),
    x = "Seconds",
    y = "Word Length",
    caption = "Esben Kran Christensen"
  )


plot1 <- ggplot(df, aes(x = df$Reaction.time)) +
  geom_histogram(aes(y = ..density.., fill = ..count.. ), binwidth = 0.01) +
  stat_function(
    fun = dnorm,
    color = "orangered2",
    size = 1,
    args = list(mean = mean(df$Reaction.time),
                sd = sd(df$Reaction.time))) +
  theme_minimal() +
  theme(text = element_text(),
    plot.subtitle = element_text(size = 14, 
                                 lineheight = 1.1,
                                 margin = margin(b = 45)),
    panel.grid.minor.x = element_blank(),
    panel.grid.minor.y = element_blank(),
    axis.text = element_text(size = 10),
    axis.text.x = element_text(margin = margin(t = 5)),
    axis.text.y = element_text(margin = margin(r = 5)),
    axis.title = element_text(size = 14),
    axis.title.y = element_text(margin = margin(r = 20),
                                hjust = 1),
    axis.ticks = element_line(),
    axis.title.x = element_text(margin = margin(t = 15),
                                hjust = 1),
    axis.line = element_line()) +
  labs(x = "Reading time", y = "Density", title = "Distribution of reading times: Nete", subtitle = "Reading times of random sequences of words")
  

plot2 <- ggplot(df, aes(x = df$Reaction.time, y = df$Word)) +
  geom_point()

grid.arrange(plot1, plot2, nrow = 2)
