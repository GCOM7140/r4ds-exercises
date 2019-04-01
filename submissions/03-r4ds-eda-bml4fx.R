library(tidyverse)

#1
ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)

# The graph has a long tail.

#2
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

# Carat

#3
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

# There is generally a positive linear relationship between carat and price.