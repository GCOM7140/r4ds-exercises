#' --- 
#' title: "r4ds exercise 3" 
#' author: Robby Byrne 
#' date: April 10, 2018 
#' output: github_document 
#' ---

knitr::opts_chunk$set(echo = TRUE) 

library(tidyverse)

?diamonds

summary(diamonds$price)

###Question 1 


diamonds %>% 
  ggplot(aes(x = price)) + 
  geom_histogram(binwidth = 30)


### Question 2 

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

# carat has the biggest effect on price 

####### Question 3 

diamonds %>%
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()

