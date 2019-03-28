library(devtools)
library(tidyverse)
library(ggplot2)
data("diamonds")



#Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

#This question is the second exercise in section 7.3.4 of R4DS. It is designed to strengthen your ability to visualize the distribution of a continuous variable with the geom_histogram() function.

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)



#Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

#We developed this question based on the second exercise in section 7.5.1 of R4DS. It is designed to strengthen your ability to interpret variable relationships from plots.

#Testing carat:
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth()

#Testing cut:
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

#Testing clarity:
ggplot(diamonds, aes(x = clarity %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

#Testing color
ggplot(diamonds, aes(x = color %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

#Carat is the best predictor of price


#Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

#How would you describe the relationship between carat and price based on these visualizations?

#We developed this question based on the second exercise in section 7.5.3 of R4DS. It is designed to strengthen your ability to interpret variable relationships from plots.

ggplot(data = diamonds, mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250)))

diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
  ) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)