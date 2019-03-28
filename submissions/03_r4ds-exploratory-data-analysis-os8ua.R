# Oliver Song os8ua
library(tidyverse)
# Question 1

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 70)

# most of the diamonds ahve low prices at around $1,500 or less. Very few diamonds cost more than $5,000

# Question 2
# carat - continuou var so use scatter
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth()

# cut - categorical so use bar or box
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

# clarity
ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_boxplot()

# color
ggplot(diamonds, aes(x = color, y = price)) +
  geom_boxplot()

# Carat appears to have the largest effect on price followed by color

# Question 3
ggplot(diamonds, mapping = aes(x = price, y = carat)) + 
  geom_boxplot(mapping = aes(group = cut_width(price, 1500)))
# carat generally increases with price

diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
  ) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)

####### ^Review, didnt figure out on my own

