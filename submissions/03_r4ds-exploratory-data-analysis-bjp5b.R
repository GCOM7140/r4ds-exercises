
#' ---
#' author: Brian J. Policard
#' title: "Exploratory Data Analysis (EDA) Solutions"
#' output: github_document
#' ---
library(tidyverse)
#' Question 1

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)

#' long-tailed with a majority of diamonds between the high hundreds and $5000.

#' Question 2
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth()

ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()


ggplot(diamonds, aes(x = clarity %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

ggplot(diamonds, aes(x = color %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

#' carat seems to have the highest effect on price of any given diamond.

#' Question 3
diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250))
  )
diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
  ) %>% 
  
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)

#' carat and price a positively corelated according to these vizualizations