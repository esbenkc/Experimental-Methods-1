library(tidyverse)

# Columns
sarah <- c(1.95, 1.58, 1.7, 2.46, 2.27, 2.62, 3.32, 3.51, 3.89, 3.41)
mother <- c(3.21, 4.04, 3.3, 3.85, 4.13, 4.59, 4.11, 4.29, 5.82, 5.14)

# Data frame
df <- data.frame(sarah, mother)
df$error_sarah <- df$sarah - mean(df$sarah)
df$error_mother <- df$mother - mean(df$mother)

# Cross
df$cross <- df$error_sarah * df$error_mother

# Sum error divide by freedom
cov <- sum(df$cross) / (nrow(df) - 1)

r <- cov / (sd(df$sarah) * sd(df$mother))

R <- r^2

ggplot(df, aes(x = df$sarah, y = df$mother)) +
  geom_point() +
  geom_smooth(method = "lm")

cor.test(sarah, mother)
