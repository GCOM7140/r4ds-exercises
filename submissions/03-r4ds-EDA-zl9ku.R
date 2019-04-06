#-------------------------------------#
# Theme: EDA r4ds   #
# Author: Roy Luo #
#------------------------------------#
library(tidyverse)

# Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)
# the majority of diamonds are below $5,000, specifically, a great proportion is around $1,000.
# The distribution has a pretty long tail.

# Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

# using boxplot to explore this question
diamonds %>%
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, .25)))
# remeber to cut width 

ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

ggplot(diamonds, aes(x = clarity %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))  
# price would be ordered by median#

ggplot(diamonds, aes(x = color %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

# Obviously, the relationship between carat and price varies the most, although there are some outliers

# Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

# Boxplot:
diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250))
  )

# Histogram: 
diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev) #?
  ) %>%  
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)

  