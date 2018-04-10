# Lucas Pulliza
# HW set 3 R4DS

library(tidyverse)

# Question 1
ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x=price), binwidth = 30)

# Question 2
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()

ggplot(diamonds, aes(x=cut, y=price)) + 
  geom_boxplot()

diamonds %>%
  mutate(carat_binned = cut(carat, breaks=c(seq(0, max(carat), .5), max(carat)))) %>%
  ggplot(., aes(x=carat_binned, y=price)) + 
  geom_boxplot()

# Question 3
diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()


