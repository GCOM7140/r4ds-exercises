#Megan Routbort 

library(tidyverse)
library(nycflights13)
library(ggplot2)

#Question 1 - Explore the distribution of price. Do you notice anything unusual or surprising? 


ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)

#The distribution is skewed with most of the diamonds being purchased as the less expensive diagrams and a few of them being purchased as the more expensive diamonds 
#most diamonds are in the $1000 range, there are a significantly fewer number that cost $10,000 or above. 

#Question 2 - Which of the 4Cs is most important for predicting the price of a diamond

#Cut and Price 
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

#Color and Price 
ggplot(diamonds, aes(x = color, y = price)) + 
  geom_boxplot()

#Clarity and Price 
ggplot(diamonds, aes (x = cut, y = price)) + 
  geom_boxplot() 

#Carat and Price 
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth()

#It makes intuitive sense that the C 'Carat' is the most important for picking the price of the diamond because while the other three Cs are related to value, most of the value of a diamond lies in how big it is. Also, price is a linear variable while the other variables are not as linearly oriented but rather are scored in terms of categories (for example color is categorical, as is cut as there are a limited # of types of diamond cuts)

#Question Three - Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250))
  )

#Next Function 

diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250))
  )


#Based on these visualizations there seems to be a derivable linear relationship between price and carat. 

