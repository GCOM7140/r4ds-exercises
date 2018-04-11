library(tidyverse)
library(ggplot2)

#Question 1: Plot the distribution of price. Describe the distribution. Hint: You can also use summary(diamonds$price) to view a quantitative assessment of the distribution.

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x=price), binwidth = 30)

  #Distribution very concentrated around 0

#Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()

ggplot(diamonds, aes(x=clarity, y=price)) + 
  geom_boxplot()

ggplot(diamonds, aes(x=cut, y=price)) + 
  geom_boxplot()

ggplot(diamonds, aes(x=color, y=price)) + 
  geom_boxplot()

diamonds %>%
  mutate(carat_binned = cut(carat, breaks=c(seq(0, max(carat), .5), max(carat)))) %>%
  ggplot(., aes(x=carat_binned, y=price)) + 
  geom_boxplot()

  #carat

#Question 3: Visualize the distribution of carat, partitioned by price. 

mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10))

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()

