library("tidyverse")
?diamonds
#Q1
diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram(binwidth = 1000)
summary(diamonds$price)

diamonds %>%
  ggplot(aes(price)) +
  geom_freqpoly()

#it's interesting to see that most diamonds fall much lower than the average price of 3933

#Q2 
diamonds %>%
  ggplot(aes(x = carat, y = price, group = carat)) +
  geom_boxplot()

diamonds %>%
  ggplot(aes(x = cut, y = price)) +
  geom_boxplot()

diamonds %>%
  ggplot(aes(x = color, y = price)) +
  geom_boxplot()

diamonds %>%
  ggplot(aes(x = clarity, y = price)) +
  geom_boxplot()

#carat is the most important for predicting the price of a diamond

#Question 3 
diamonds %>%
filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()

