library(tidyverse)

#Question 1#

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)

# The distribution has a very long tail to the most expensive diamonds. However,
# the majority of diamonds are $1,000 with a small bump below $5,000.

#Question 2#

# Carat is the clear winner. While there are a number of ways to visualize
# covariation between the 4Cs and price, the plots below suggest that the
# relationship appears to be most dramatic between carat and price.

# The relationship between carat and price can be explored with a scatterplot
# via the geom_point() function
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth()


# The relationship between the categorical Cs (clarity, color, and cut) and
# price can be explored with box plots via the geom_boxplot() function
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

ggplot(diamonds, aes(x = clarity %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

ggplot(diamonds, aes(x = color %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

# To look at the carat variable as a box plot for consistency purposes, carat
# can be binned using the `cut_width()` function from the ggplot2 package.
diamonds %>%
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, .25)))

#Question 3#

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
 
