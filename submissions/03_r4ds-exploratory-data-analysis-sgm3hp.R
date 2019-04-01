library(tidyverse)

#Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)
ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x=price), binwidth = 75)

#Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point()+ 
  geom_smooth()

ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot() 

ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_boxplot()

ggplot(diamonds, aes(x = color, y = price)) +
  geom_boxplot()

#carat seems to have the most important relationship with the price of diamonds accordi

#Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function. How would you describe the relationship between carat and price based on these visualizations?

diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(mapping = aes(group = price %>% cut_width(width = 2500, center = 1250)))


diamonds %>%
  mutate(price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)


#from the boxplot the relationship between carat and price seems to be that as carat increases price increases but there also becomes more variability in the price as the carat increases. from the boxplot it can be determined that there is a distribution in the diamonds for each of the prices. 

