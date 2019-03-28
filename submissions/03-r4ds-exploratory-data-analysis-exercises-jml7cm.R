### This code continues on from the 2nd exercise related to R for Data Science and is tied to Chapter 7 of that text

#' title: "Exploratory Data Analysis (EDA) Solutions"
#' author: McLean Long (jml7cm)
#' output: github_document

# Remember to load libraries before starting

library(tidyverse)

### Question 1 ### - asks for explanation of distribution of price

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)

### Question 2 ### - this queston is all about relationships

# Part 1 - this visualization would be hard for me to interpret except for the basic trend line that follows through the data, but this is, in my opinion, the most stunning data visualization in R that we have done in any class thus far. 

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth()

# Part 2

ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

# Part 3 

ggplot(diamonds, aes(x = clarity %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

# Part 4

ggplot(diamonds, aes(x = color %>% fct_reorder(price), y = price)) +
  geom_boxplot() +
  coord_cartesian(ylim = c(0, 7500))

# Final part of the question - requires further thinking about Chapter 7 of R for Data Science

# This is another really cool visualization that I would be interested in using for the TJL propsal and or final project

diamonds %>%
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, .25)))

### Question 3 ###

diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250))
  )

# 2nd part of this question is pretty similar

diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
  ) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)

### End of R4DS exercises code until Exercise 4 ###




