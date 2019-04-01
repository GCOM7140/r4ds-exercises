# Justin Lagomarcino

library(tidyverse)
library(nycflights13)
library(ggplot2)

# Question 1 - Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 100)

# Looks like a majority of diamonds are priced in the 1k range. Long tail past 15k.

# Question 2 - Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

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

ggplot(mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, .25)))

# Carat has the most predictive power of the four C's for price. All of the C's have an impact but the impact of carat is the most prevelant. 

# Question 3 - Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250))
  )

diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
  ) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)

# Relationship between price and carat is fairly linear.