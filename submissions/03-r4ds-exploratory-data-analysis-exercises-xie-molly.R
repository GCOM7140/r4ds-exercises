library(tidyverse)
Question #1

diamonds %>% 
  ggplot(aes(price)) + geom_histogram()

summary(diamonds$price)

diamonds %>% ggplot(aes(price)) + geom_histogram(binwidth = 100)

diamonds %>% ggplot(aes(price)) + geom_boxplot()



Question #2
ggplot(diamonds) + geom_point(aes(x = carat,     y = price))
ggplot(diamonds) +geom_boxplot(aes(x = cut,     y = price))
ggplot(diamonds) + geom_boxplot(aes(x = color,   y = price))
ggplot(diamonds) + geom_boxplot(aes(x = clarity, y = price))
#The largest predictor for the price of the diamond is the number of carats it contains.

Question #3
diamonds %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf),
                            dig.lab = 10)) %>% 
  ggplot() +
  geom_boxplot(aes(price_binned, carat))

diamonds %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf),
                            dig.lab = 10)) %>% 
  ggplot() +
  geom_histogram(aes(carat)) +
  facet_wrap(~ price_binned)