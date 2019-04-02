# Name: Pan Xiao
# Assignment: r4ds-exercise

library(tidyverse)

# Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

diamonds %>%
  ggplot(mapping = aes(x = price), binwidth = 100) +
  geom_histogram()

# Most diamonds are under $5,000 and the diamonds under $1,000 are the majority. Diamond prices over 10,000 are minority. 


# Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

diamonds %>%
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth()

diamonds %>%
  ggplot(mapping = aes(x = cut, y = price)) +
  geom_point() +
  geom_smooth()

diamonds %>%
  ggplot(mapping = aes(x = clarity, y = price)) +
  geom_point() +
  geom_smooth()

diamonds %>%
  ggplot(mapping = aes(x = color, y = price)) +
  geom_point() +
  geom_smooth()

# Carat is the most important for predicting the price of a diamond since there exists a upward trend as carat increases by a factor of 1. 


# Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

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







