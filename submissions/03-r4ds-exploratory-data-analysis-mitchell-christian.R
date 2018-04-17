# R4DS Homework 3
  # Christian Mitchell

library(tidyverse)

# Question 1

diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram(binwidth = 100)

summary(diamonds$price)

    # This distribution has a long tail, meaning there are a small proportion of diamonds that are much more expensive than the rest. However, the majority of diamonds are under $5000, with a lot being around or under $1000

# Question 2

diamonds %>% 
  ggplot(aes(price, carat)) +
  geom_point() +
  geom_smooth(formula = price ~ karat, color = 'blue')

diamonds %>% 
  ggplot(aes(cut, price)) +
  geom_boxplot()

diamonds %>% 
  ggplot(aes(color, price)) +
  geom_boxplot()

diamonds %>% 
  ggplot(aes(clarity, price)) +
  geom_boxplot()  

    # The most telling relationship between the price and attribute of these plots seems to be price.

# Question 3

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>% 
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  ) %>% ggplot(aes(price_binned, carat)) +
  geom_boxplot()
  

