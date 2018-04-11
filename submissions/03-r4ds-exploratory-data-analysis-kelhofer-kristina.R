#' ---
#' title: R4DS Data Visualization Exercises
#' author: Kristina Kelhofer
#' date: April 10, 2018
#' ouptut: github_document
#' ---
#' ================
#' 
library(tidyverse)
?diamonds
#' Exercise 1
diamonds %>% 
  filter(clarity == "IF") %>%
  ggplot(aes(price)) + 
  geom_histogram(binwidth = 100)

summary(diamonds$price)

# from my investigation, an interesting finding is that diamonds with the most desirable level of clarity have prices that are concentrated in the lower end of the spectrum. The majority fall below the median. My hunch is that smaller diamonds are much more likely to have perfect clarity, but that size is more important when determining price.

# Exercise 2
   # Histogram to determine differences 
 ggplot(data = diamonds, mapping = aes(x = price)) + 
      geom_freqpoly(mapping = aes(colour = cut), binwidth = 500)
    
    ggplot(data = diamonds, mapping = aes(x = price)) + 
      geom_freqpoly(mapping = aes(colour = clarity), binwidth = 500)
    
    ggplot(data = diamonds, mapping = aes(x = price)) + 
      geom_freqpoly(mapping = aes(colour = carat), binwidth = 500)
    
    ggplot(data = diamonds, mapping = aes(x = price)) + 
      geom_freqpoly(mapping = aes(colour = color), binwidth = 500)
    
    #Boxplots to determine differences
    ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
      geom_boxplot()
    ggplot(data = diamonds, mapping = aes(x = color, y = price)) +
      geom_boxplot()    
    ggplot(data = diamonds, mapping = aes(x = clarity, y = price)) +
      geom_boxplot()
    
    ggplot(data = diamonds, mapping = aes(x = carat, y = price)) + 
      geom_line()

# Exercise 3
    diamonds %>% 
      mutate(
        price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                           dig.lab = 10)
      ) %>% 
      ggplot(aes(x = price_binned, y = carat)) +
      geom_boxplot()

    diamonds %>% 
      mutate(
        price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                           dig.lab = 10)
      ) %>% 
      ggplot(aes(x = price, y = carat), facet = price_binned) +
      geom_histogram()
    # This shows that higher priced diamonds are associated with higher carat levels.      