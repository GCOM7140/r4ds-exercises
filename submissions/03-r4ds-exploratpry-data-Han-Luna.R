#' ---
#' title: "Answers to R4DS exploratory data analysis exercises"
#' author: Luna Han
#' date: April 10, 2018
#' output: github_document 
#' --- 

library(tidyverse)
?diamonds
  
#Exercise 1
diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()
#distribution：the prices of the most diamonds are at the lowest level.

#Exercise 2
diamonds %>%
  ggplot(aes(x=carat, y=price)) + 
  geom_point()
# price has a significant positive relationship with carat.
diamonds %>%
  ggplot(aes(x=cut, y=price)) + 
  geom_point()
# each level of cut has a similiar price range.
diamonds %>%
  ggplot(aes(x=cut, y=price)) + 
  geom_point()
#except for I1, most of the levels of clarity have a similiar price range.
diamonds %>%
  ggplot(aes(x=color, y=price)) + 
  geom_point()
# each color has a similiar price range.
# therefore carat is most important to predict the price of a diamond.

#Exercise 3
diamonds %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10)) %>%
  ggplot(aes(x=carat, y=price_binned)) + 
  geom_point() +     
  geom_boxplot()

