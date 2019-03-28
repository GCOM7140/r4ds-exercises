# ++++++++++ r4ds Exploratory Data Analysis Exercises ++++++++++


library(tidyverse)


# Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)

# The distribution has a long tail to the most expensive diamonds, but the majority of diamonds are between $0 and $2,500.

# Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

# Carat
ggplot(data = diamonds, aes(x = carat, y = price)) + 
  geom_point() +
  geom_smooth()

diamonds %>%
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, .25)))

# Cut
ggplot(data = diamonds, aes(x = cut, y = price)) + 
  geom_boxplot()

# Clarity
ggplot(diamonds, aes(x = clarity %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

# Color
ggplot(diamonds, aes(x = color %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

# It appears that carat is the strongest predictor of price. 

# Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function. How would you describe the relationship between carat and price based on these visualizations?

# Using boxplot
diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250))
  )

# Using histogram
diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
  ) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)

# Price and carat have a positive relationship. As price increases, carat increases, and vice versa. 