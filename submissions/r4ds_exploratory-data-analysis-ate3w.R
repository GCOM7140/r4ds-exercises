# Exploratory Data Analysis

library(tidyverse)

# Question 1
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 80)

# The range is very wide, but most diamonds are cheap

# Question 2

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth()

ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

ggplot(diamonds, aes(x = clarity %>% fct_reorder(price), y = price)) +
  geom_boxplot() +
  coord_cartesian(ylim = c(0, 7500))

ggplot(diamonds, aes(x = color %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

# Carat is most important

# Question 3
diamonds %>%
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2000, center = 750))
  )
