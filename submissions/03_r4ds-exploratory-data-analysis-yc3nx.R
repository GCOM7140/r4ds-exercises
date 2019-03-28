library(tidyverse)
# Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

# This question is the second exercise in section 7.3.4 of R4DS. It is designed to strengthen your ability to visualize the distribution of a continuous variable with the geom_histogram() function.

ggplot(diamonds，aes(price)) + 
  geom_histogram(binwidth = 100)+ 
  xlim(0,10000)

# The distribution is a right skewed standard curve except for there are very few at price = 1500. 


# Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?
  
  # We developed this question based on the second exercise in section 7.5.1 of R4DS. It is designed to strengthen your ability to interpret variable relationships from plots.

ggplot(diamonds,aes(carat,price))+
 geom_point()+
  geom_smooth()

ggplot(diamonds,aes(color%>%fct_reorder(price),price))+
  geom_boxplot()+
  ylim(0,7000)

ggplot(diamonds,aes(clarity%>%fct_reorder(price),price))+
  geom_boxplot()+
  ylim(0,10000)

ggplot(diamonds, aes(color %>% fct_reorder(price), price)) +
  geom_boxplot() + 
  ylim (0, 7500)

# carat seems to be most predictive of price

  

# Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

ggplot(diamonds,aes(carat,price))+
  geom_boxplot(mapping = aes(group = cut_width(carat, .25)))

diamonds %>%
  mutate(price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)

# How would you describe the relationship between carat and price based on these visualizations?
# Price increases as carat increase, but there's a standard curve in each price bin.
  
  # We developed this question based on the second exercise in section 7.5.3 of R4DS. It is designed to strengthen your ability to interpret variable relationships from plots.