library(tidyverse)

?diamonds

# Exercise 1

diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()

summary(diamonds$price)

geom_histogram()

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x=price), binwidth = 30)

# Exercise 2

# carat

# Exercise 3

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()
