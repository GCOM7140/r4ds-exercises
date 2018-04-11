# Jenny Zhao
# April 10
library(tidyverse)

# Exercise 1
?diamonds
diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()

summary(diamonds$price)

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 30)

# The distribution is skew to the right. When the price is less then 2500, count are generally greater than 250. There are also a lot of price point in the diamonds dataset.

# Exercise 2
# carat is most important for predicting the price of a diamond.
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_point()

# cut
ggplot(data = diamonds, mapping = aes(x = price)) + 
  geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)

# clarity 
ggplot(data = diamonds, mapping = aes(x = clarity, y = price)) +
  geom_boxplot()

# color
ggplot(data = diamonds) +
  geom_count(mapping = aes(x = color, y = price))

# Exercise 3
diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab = 10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()
