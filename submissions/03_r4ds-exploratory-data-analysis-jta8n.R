library(tidyverse)

# Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = price), binwidth = 100)

# The price of diamonds is drastically weighted to the under $5000 price however there is an extremely long tail almost all the way to $20,000. Basially most people are not rich

# Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_freqpoly(mapping = aes(color = carat), binwidth = 100)

ggplot(diamonds, aes(x = color, y = price)) +
  geom_point() + 
  geom_smooth()

ggplot(diamonds, aes(x = cut, y = price)) + 
  geom_boxplot()

# when testing all of them in the point plot with a line overlay we see that because carat is the only continuous variable it is by far the best predictor. I also came to the same conclusion when mapping each variable on a frequency map and comparing that to the price histogram, where carat followed most closely in quanity to the quantity in price histogram.

# Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

ggplot(diamonds, aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2000, center = 500)
    ))

diamonds
diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
  ) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)
rlang::last_error()






