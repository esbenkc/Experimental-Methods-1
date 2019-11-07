#########################
### Comment data from ###
### beautiful dataviz ###
#########################

setwd("C:/Users/esben/Documents/Experimental-Methods-1/data_viz")
df <-
  read_csv("https://raw.githubusercontent.com/RedditFormula1/Data/master/commentdata.dat")

### User activity as +1 for each upvote and downvote in 15 minute intervals
### n = 30,000 for hidden 0 minutes, 30 minutes, and 60 minutes
### Score calculated

###########################
### Visualization tests ###
###########################

pacman::p_load(tidyverse)

### Tidyverse is a collection of packages: dplyr, ggplot2, readr, tidyr, purr, and openss

barplot(iris$Petal.Length)
data(iris)
par(mfrow = c(2, 2))
boxplot(iris$Sepal.Length, col = "red")
boxplot(iris$Sepal.Length ~ iris$Species, col = topo.colors(3))
pie(table(iris$Species))

# Plots the data (mpg is part of ggplot2) and sets the mapping parameters (x and y axis) using
# Works by adding layers to the ggplot (in this case geom_point function adds a point layer)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = mpg$displ, y = mpg$hwy))

# ggplot(data = <DATA>) +
#   <GEOM_FUNCTION>(mapping = aes(<MAPPINGS>))

length(mpg)
length(mpg$manufacturer)

? mpg

ggplot(data = mpg) +
  geom_point(mapping = aes(
    x = mpg$displ,
    y = mpg$hwy,
    shape = mpg$class
  ),
  color = "blue")

# Different aesthetic attributes: color, shape, size, alpha, x, y
# aes() decides information transmitting aesthetics
# General aesthetic decisions outside of aes()

filter(mpg, mpg$hwy > 20 & mpg$displ > 5)

# https://r4ds.had.co.nz/data-visualisation.html
# Excercises 3.3.1
# 1: If the "blue" is set as a variable represented by the color attribute inside aes() it will show "blue" in a legend and the points will be red
# 2: This is the column variable types (categorical, continuous): cat, cat, con, con, con, cat, cat, con, con, cat, cat
# 3:
ggplot(data = mpg) +
  geom_point(mapping = aes(
    x = mpg$displ,
    y = mpg$hwy,
    color = mpg$year,
    size = mpg$displ
    #, shape = mpg$year
  ))
#> Error: A continuous variable can not be mapped to shape
# 4: The variable affects both aesthetics if mapped to two
# 5: The stroke aesthetic creates stroke thickness on possible shapes (e.g. 23, 24, 25)
ggplot(data = mpg) +
  geom_point(
    mapping = aes(
      x = mpg$displ,
      y = mpg$hwy,
      alpha = mpg$cyl,
      stroke = mpg$cyl * 0.25,
      fill = mpg$drv
    ),
    size = 3,
    color = "blue",
    shape = 23
  )
# 6: What happes when aesthetic used on other than variable?
ggplot(data = mpg) +
  geom_point(mapping = aes(
    x = mpg$displ,
    y = mpg$hwy,
    colour = mpg$displ < 4
  ))
# Creates color classes based on TRUE or FALSE

### Excercise in Intro to Data Visualization with R & ggplot2
ggplot(mpg, aes(x = mpg$displ, fill = mpg$drv)) +
  facet_wrap(~ mpg$class) +
  geom_density(alpha = 0.5) +
  labs(y = "Size",
       x = "Displ",
       title = "Motor size by model and rear, front, or 4-wheel drive")

library(gganimate)
library(gifski)
library(gapminder)
library(devtools)
devtools::install_github('thomasp85/gganimate')
library(gganimate)
pacman::p_

### animate, gganimate, plotly, googlevis
ggplot(
  df,
  aes(
    x = cotdata$X.timestamp,
    y = df$X1.00.score,
    fill = df$amount.of.minutes.the.scores.were.hidden
  )
) +
  geom_density(y = df$x1.00.score, alpha = 0.5)

df
load(gganimate)
install.packages('png')
library(png)

### Excercise in use of gganimate
ggplot(iris, aes(x = iris$Petal.Length, fill = iris$Species)) +
  geom_density(alpha = 0.5)

ggplot(mpg, aes(x = mpg$displ, fill = mpg$hwy)) +
  geom_bar() +
  labs(title = 'Year: {frame_time}', x = 'Miles per gallon', y = 'Motor size') +
  transition_time(mpg$year) +
  ease_aes('linear')

df$`#timestamp` <- as.integer(df$`#timestamp`)
df$min_hidden <- df$min_hidden %>% as.integer()
df$`0:15 score` <- df$`0:15 score` %>% as.integer()
df$`0:30 score` <- df$`0:30 score` %>% as.integer()
df$`0:45 score` <- df$`0:45 score` %>% as.integer()
df$`1:00 score` <- df$`1:00 score` %>% as.integer()
df$`1:15 score` <- df$`1:15 score` %>% as.integer()
df$`1:30 score` <- df$`1:30 score` %>% as.integer()
df$`1:45 score` <- df$`1:45 score` %>% as.integer()
df$`2:00 score` <- df$`2:00 score` %>% as.integer()

df

df$polarity <- case_when(df[["0:15 score"]] < 0 ~ "negative",
                         df[["0:15 score"]] > 0 ~ "positive",
                         df[["0:15 score"]] == 0 ~ "zero")
df$polarity <- as.factor(df$polarity)

library(tidyverse)

names(df)[2] <- paste("min_hidden")

viz_df <-
  df %>% group_by(polarity, 'min_hidden') %>% summarise_all(mean)

ggplot(data = viz_df, aes(x = viz_df$min_hidden, y = viz_df$`0:15 score`)) + geom_bar()

viz_df
