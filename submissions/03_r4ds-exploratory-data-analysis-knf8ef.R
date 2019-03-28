###########################################
### GCOM 7140 (Customer)                ###
### Exploratory Data Analysis Exercises ###
### R4DS, Chapter 7                     ###
### 3/28/19                             ###
###########################################


### file name: 03_r4ds-exploratory-data-analysis-knf8ef.R


library(tidyverse)


### Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)

# The plot is skewed right and the majority of prices is between 0 and 2,500.


### Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_smooth()
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()
ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_boxplot()
ggplot(diamonds, aes(x = color, y = price)) +
  geom_boxplot()

# Carat is most important for predicting dimond price.


### Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(mapping = aes(group = price %>% cut_width(width = 2500, center = 1250)))

diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
    ) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~ price_binned, scales = "free_y", ncol = 1)

# As the number of carats increases, price increases. The number of carats is higher at higher prices.