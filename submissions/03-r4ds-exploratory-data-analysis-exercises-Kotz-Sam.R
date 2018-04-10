#Sam Kotz
#R4DS Questions 

#1
library(tidyverse)
summary(diamonds$price)
diamonds %>% 
  ggplot(aes(price)) + 
  geom_density(fill = "red")

# The distribution obviously has an extremely long right tail, but the interesting thing about the density plot is how such a huge percentage of the pricers fall below $2000, and how there is a small "hump" right before $5000.

#2

ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()

ggplot(diamonds, aes(x=cut, y=price)) + 
  geom_boxplot()

ggplot(diamonds, aes(x=clarity, y=price)) + 
  geom_boxplot()

ggplot(diamonds, aes(x=color, y=price)) + 
  geom_boxplot()

# the above scatter and boxplots show that Carat has the strongest relationship to the price of a diamond. 

#3

diamonds %>% 
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  ) %>% ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()
