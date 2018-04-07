#' ---
#' title: "R4DS exploratory data analysis"
#' author: Burhan Khan
#' date: April 7, 2018
#' output: github_document
#' ---

knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)

#Question 1:
?diamonds
diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram(aes(fill = clarity)) +
  scale_x_log10() +
  theme_bw()

#There does not seem to be much correlation between clarity and price. Most diamonds are on the cheaper end of the range.

#Question 2:
ggplot(diamonds, aes(x = carat, y =price)) +
  geom_point(alpha = .8, shape = 21, col = "black", fill = "yellow") +
  geom_smooth()

ggplot(diamonds, aes(x = cut, y =price)) +
  geom_jitter(alpha = .8, width = .1)

ggplot(diamonds) +
  geom_jitter(aes(x = clarity, y =price), alpha = .8, width = .2)

ggplot(diamonds) +
  geom_jitter(aes(x = color, y =price), alpha = .8, width = .2)

#Carat is the most important predictor


#Question 3:
diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()
