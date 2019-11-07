#############################
### Data mining excercise ###
### on personality data   ###
#############################

setwd("C:/Users/esben/Documents/Experimental-Methods-1/190912_personality_analysis")
df <- read.table("NEW_CogSciPersonalityTest2019.csv", header = TRUE, sep = ",")
df <- read.csv("NEW_CogSciPersonalityTest2019.csv")

### install.packages(string packagename) just once
### library(packagename) every file
### pacman::p_load(packagename) use this instead

pacman::p_load(tidyverse)

### Tidyverse is a collection of packages: dplyr, ggplot2, readr, tidyr, purr, and openss
### Search "Packagename cheatsheet R" on google for cheatsheets for a lot of package functions

# pick observation by specified data
esben <- filter(df, df$name == "Esben" & df$birth_day == "1999-07-30")
shoes40 <- filter(df, df$shoesize == 40)
bigfoot_analysis <- filter(df, df$shoesize >= 45)

### Excercise 1 combined data: Shoe > 39, yes touch floor, breath > mean, 13 < baloon balance < 60
shoesover39 <- filter(df, df$shoesize > 39 & (df$touch_floor == "Yes" | df$touch_floor == "Yes, of course!!") & df$breath_hold > mean(df$breath_hold) & (13 < df$balloon_balance & df$balloon_balance < 60))

### Excercise 2 arrange()

# arrange data in order (desc() to arrange in descending order)
# several columns will sort out conflicts in previous column
tongue_twist <- arrange(df, desc(tongue_twist))

romberg <- arrange(df, df$romberg_open, df$romberg_closed)
romberg <- df[,c("name","romberg_open","romberg_closed")]
romberg <- arrange(romberg, c("romberg_open","romberg_closed"))
romberg

### Excercise 3 select()

# select() creating subset of interesting variables
# a zoom function on the columns
select(df, df$name, df$gender)
select(df, df$name:df$gender)
select(df, -c(df$name:df$gender, df$vis_duck:df$taste_jam))

NN <- select(df, df$name, df$name) # gives only one column
var = c("name", "shoesize", "touch_floor")
select(df, var)
# can select with variable name vector

rearranged_df <- select(df, df$gender, df$shoesize, df$everything())
rearranged_df <- select(df, -c(df$X))


### Excercise 4 mutate()

# creates new column with mathematical operation on other columns

df <- mutate(df, words_per_sec = 99 / df$tongue_twist)
mutate(df[df$name == c("Esben"),], words_per_sec = 99 / df[df$name == c("Esben"),]$tongue_twist)
df <- mutate(df, breath_min = df$breath_hold %/% 60)
df <- mutate(df, breath_sec = df$breath_hold %% 60)
df <- mutate(df, wps_mean = df$words_per_sec - mean(df$words_per_sec))
df

###

df
df_selected <- select(df,c("X","name","gender","breath_hold"))
mean(df_selected$breath_hold)

df_selected$deviance <- df_selected$breath_hold - mean(df_selected$breath_hold)
sum(df_selected$deviance)
round(sum(df_selected$deviance))

df_selected$SS <- df_selected$deviance^2
sum(df_selected$SS)

variance <- sum(df_selected$SS) / length(df_selected$X) - 1
standard_error <- sqrt(variance)
standard_error

sd(df_selected$breath_hold)
df_selected <- arrange(df_selected, breath_hold)
df_selected

ggplot(df) +
  aes(y = df$breath_hold, x = df$tongue_twist, alpha = 0.7) +
  geom_point()
    
###
  
library(magick) 
library(gapminder)
library(ggplot2)
pacman::p_load(rsvg)
pacman::p_load(lubridate)
devtools::install_github('thomasp85/gganimate')
library(gganimate)
pacman::p_load(ggplot2)



ggplot(df) +
  aes(position = 'identity', fill = df$gender, colour = df$gender, size = df$choose_rand_num, alpha = 0.5, x = df$birth_day, y = df$breath_hold) +
  geom_point(show.legend = FALSE) +
  geom_smooth(show.legend = FALSE, formula = y ~ x, method = 'loess') +
  labs(title = "Mean length of utterances for child and mother during 3 years at {frame_time}", subtitle = "MLU calculated using word sum and utterances during each day over the period\nBlue represents mother, red represents child, and point size represents word sum", x = "Date", y = "MLU")

