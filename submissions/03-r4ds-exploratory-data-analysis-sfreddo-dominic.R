#' ---
#' title: "R4DS Exercise #3"
#' author: Dominic Sfreddo
#' date: April 10, 2018
#' output: github_document
#' ---

knitr::opts_chunk$set(echo = TRUE)


library(knitr)
library(tidyverse)
?diamonds

#1

summary(diamonds$price)

#Histogram examining price in general

diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()

#Plot examining price as it varies with carat

diamonds %>% 
  ggplot(aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth()

#The distribution is skewed right and contains a majority of low price diamonds, which is surprising given all of the different carats of diamonds. It's odd that there are so few high price diamonds.

#2

#Point plots with a trendline to examine distribution and predictive capabilities of the 4 c's.

diamonds %>% 
  ggplot(aes(x = carat, y = price)) +
  geom_point() +
  geom_smooth()

diamonds %>% 
  ggplot(aes(x = cut, y = price)) +
  geom_point() +
  geom_smooth()

diamonds %>% 
  ggplot(aes(x = color, y = price)) +
  geom_point() +
  geom_smooth()

diamonds %>% 
  ggplot(aes(x = clarity, y = price)) +
  geom_point() +
  geom_smooth()

#Carat is the best predictor of price of a diamond.

#3

#initial plot of carat and fill by price bin

diamonds %>% 
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  ) %>% 
  ggplot(aes(carat)) +
  geom_histogram(aes(fill = price_binned), position = "fill", binwidth = .1)

#added a facet wrap to first plot to view distribution by carat

diamonds %>% 
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  ) %>% 
  ggplot(aes(carat)) +
  geom_histogram(aes(fill = price_binned), binwidth = .1) +
  facet_wrap(~ price_binned, scales = "free_y", ncol = 1)

