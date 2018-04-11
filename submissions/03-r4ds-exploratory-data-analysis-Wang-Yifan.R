library(tidyverse)
?diamonds

# Question 1
summary(diamonds$price)
diamonds %>% 
  ggplot(aes(x = price)) + 
  geom_histogram(binwidth = 100)
# From the graph, we can see the price distribution skews to the left.


# Question 2
diamonds %>%
  ggplot(aes(x=carat, y=price)) + 
  geom_point()
# There shows there is a positive correlation between price and caret.

diamonds %>%
  ggplot(aes(x=cut, y=price)) + 
  geom_point()
# The price range for each level of cut is similar.

diamonds %>%
  ggplot(aes(x=clarity, y=price)) + 
  geom_point()
# Except for I1, the price range for each level of clarity is similar.

diamonds %>%
  ggplot(aes(x=color, y=price)) + 
  geom_point()
# The price range for each color is similar.
# Carat is the most important for predicting the price of a diamond.


# Question 3
diamonds %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10)) %>%
  ggplot(aes(x=carat, y=price_binned)) + 
  geom_point() +     
  geom_boxplot()