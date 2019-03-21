library(tidyverse)

# Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(data = diamonds) + geom_histogram(mapping = aes(x = price))

# Most of the diamonds are low price.

# Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

# Pass

# Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

ggplot(data = diamonds, mapping = aes(x = price, y = carat)) + geom_boxplot(mapping = aes(group = price %>% cut_width(width = 2000, center = 1250)))

# There is a curvilinear relationship between carat and price. 
# Generally as carat increases, price increases with a decreasing rate of increase
