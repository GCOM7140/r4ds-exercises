library(tidyverse)

#Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? 
ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram(binwidth = 10)
#There is zero counts of Diamonds priced ~$1500

#Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

#Positive relation between carats and price
ggplot(data = diamonds, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)))

#negative relation between colors (Best:D - Worst:J) and prices
ggplot(data = diamonds, mapping = aes(x = color, y = price)) +
  geom_boxplot()

#negative relation between clarity (I1 (worst) to IF (best)) and prices.
ggplot(data = diamonds, mapping = aes(x = clarity, y = price)) +
  geom_boxplot()

#not a strong relation between cut and price hence carat is most important
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()

#Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

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