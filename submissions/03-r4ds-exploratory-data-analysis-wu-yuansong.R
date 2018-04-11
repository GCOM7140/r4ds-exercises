#Data Exploratory Exercise - r4ds
#Yuansong(Kevin) Wu

library(tidyverse)
?diamonds

# Exercise 1
summary(diamonds$price)
diamonds %>% 
  ggplot(aes(x = price)) + 
  geom_histogram(binwidth = 100)
# The price distribution skews to the left.


# Exercise 2
diamonds %>%
  ggplot(aes(x=carat, y=price)) + 
  geom_point()
# There is a positive correlation between price and caret.
diamonds %>%
  ggplot(aes(x=cut, y=price)) + 
  geom_point()
# The price range for each level of cut is similar.
diamonds %>%
  ggplot(aes(x=clarity, y=price)) + 
  geom_point()
# The price range for each level of clarity is similar except for I1.
diamonds %>%
  ggplot(aes(x=color, y=price)) + 
  geom_point()
# The price range for each color is similar.
# We can see that carat is the most important for predicting the price of a diamond.

# Exercise 3
diamonds %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10)) %>%
  ggplot(aes(x=carat, y=price_binned)) + 
  geom_point() +     
  geom_boxplot()

