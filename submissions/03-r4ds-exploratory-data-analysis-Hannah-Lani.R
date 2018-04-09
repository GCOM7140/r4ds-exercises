#' ---
#' Title: R4DS HW 3
#' Date:  April 8, 2018
#' Who:   Lani Hannah 
#'--- 

library(tidyverse)
?diamonds

#' Question 1: Explore the distribution of price with geom_histogram() and other functions. 
#' basic stats 
summary(diamonds$price)
var(diamonds$price)
cov(diamonds$price, diamonds$carat)
cor(diamonds$price, diamonds$carat) #price and carat are highly correlated

#' histogram
diamonds %>% 
  ggplot(aes(x = price)) +
  geom_histogram(binwidth = 30)


#' Question 2: Which of the 4Cs (i.e., carat, cut, color, and clarity) is most important for predicting the price of a diamond? Looks like carat is the most important variable for predicting diamond price. 

#' scatterplot
diamonds %>% 
  ggplot() + 
  geom_point(aes(x = carat, y = price)) 

#' visuals for categorical variables
diamonds %>% 
  ggplot() +
  geom_boxplot(aes(x = cut, y = price))

diamonds %>% 
  ggplot() +
  geom_boxplot(aes(x = color, y = price))

diamonds %>% 
  ggplot() +
  geom_boxplot(aes(x = clarity, y = price))



#' Question 3: Visualize the distribution of carat, partitioned by price. Then,   after revisiting Faceting, use facet_wrap() to accomplish the same.

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab = 10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()

#' trying out facet wrapping with cut
diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), 
                                              max(price)), dig.lab = 10)) %>%
  ggplot(., aes(price_binned, carat)) +
  geom_boxplot() +
  facet_wrap(~cut , nrow = 3) +
  theme(axis.text.x = element_text(angle = 30, hjust = 1))


