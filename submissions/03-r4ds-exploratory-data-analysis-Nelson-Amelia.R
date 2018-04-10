#' --- 
#' title: "r4ds exercise 3" 
#' author: Amelia Nelson
#' date: April 10, 2018 
#' output: github_document 
#' ---

library(tidyverse)
?diamonds

# Question 1: Explore the distribution of price with geom_histogram() and other functions. Use prose to describe the distribution you utlimately discover. What are some of the most surprising features of the distribution to you?

diamonds %>% 
  ggplot(aes(x=price)) + 
  geom_histogram(binwidth = 50)

# The graph 

# Question 2: Which of the 4Cs (i.e., carat, cut, color, and clarity) is most important for predicting the price of a diamond?

# carat vs price scatterplot
diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_point()

# cut vs price scatterplot
diamonds %>%
  ggplot(aes(x = cut, y = price)) +
  geom_point()

# color vs price scatterplot
diamonds %>%
  ggplot(aes(x = color, y = price)) +
  geom_point()

# clarity vs price scatterplot
diamonds %>%
  ggplot(aes(x = clarity, y = price)) +
  geom_point()

# It is clear that carat is the biggest factor when When plotting the carat of a diamond versus the price of the diamond, we can see an exponential inrease. From a one carat diamond to a 2 carat diamond, there is a huge jump in price. After 2 carats, prices don't differentiate by carat as much.
