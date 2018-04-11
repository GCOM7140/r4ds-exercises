#' George Dowling HW#3
#' R4DS
##' April 10, 2018
  
library(tidyverse)
library(ggplot2)

####' Question 1 ####
ggplot(diamonds, aes(price))+
  geom_histogram(bins = 25, fill = "lightblue", color = "black")

#' The distribution of the of the histogram is extremely skewed to the lower side of the price range.  

####' Question 2 ####

#' Looking at carat
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()

#' Looking at cut
ggplot(diamonds, aes(cut, price)) + 
  geom_boxplot()

#' Looking at clarity
ggplot(diamonds, aes(clarity, price)) +
  geom_boxplot()

#' Looking at color
ggplot(diamonds, aes(color, price)) + 
  geom_boxplot()
                    

####' Question 3 ####

#' Done without faceting

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), max(price)), dig.lab=10)) %>%
  ggplot(aes(price_binned, carat)) + 
  geom_boxplot(fill = "lightblue", color = "pink")

#' done by faceting

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, 
                            breaks=c(seq(0, max(price), 5000), Inf), 
                            dig.lab=10)) %>%
  ggplot(., aes(x=carat, fill=price_binned)) + 
  geom_histogram(bins=25) + 
  facet_wrap(~ price_binned, scales = 'free_y', ncol = 1) +
  guides(fill=FALSE)
