library(tidyverse)
library(ggplot2)

#Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)
diamonds %>%
  ggplot(mapping = aes(x = price)) +
  geom_histogram(binwidth = 10) +
  coord_cartesian(xlim = c(1000, 2500))
  
#Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

diamonds %>%
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.5)))

diamonds %>%
  ggplot(mapping = aes(x = cut, y = price)) +
  geom_boxplot()

diamonds %>%
  ggplot(mapping = aes(x = clarity, y = price)) +
  geom_boxplot()

diamonds %>%
  ggplot(mapping = aes(x = color, y = price)) +
  geom_boxplot()

#Carat is the most important factor for determining the price of dimonds


#Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

diamonds %>%
  ggplot(mapping = aes(y = carat, x = price)) +
  geom_boxplot(mapping = aes(group = cut_width(price, 5000)))

#Diamonds with more carats are sold at higher prices. 

diamonds %>%
  mutate(price_level = price %>%
           cut_width(width = 1000) %>%
           fct_relevel(rev)
         ) %>%
  ggplot(mapping = aes(x = price)) +
    geom_histogram()+
    facet_wrap(~price, ncol = 5)
  