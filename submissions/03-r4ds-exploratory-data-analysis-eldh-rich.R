#--------------------------------------------------------
#Rich Eldh
#Professor Boichuk
#Customer Analytics
#Due Date: 10 April 2018
#--------------------------------------------------------

#--------------------------------------------------------
#Assignment 3: R4DS Exploratory Data Analysis
#--------------------------------------------------------

library(tidyverse)
?diamonds

#--------------------------------------------------------
#Question 1
#--------------------------------------------------------
#Histogram mapping price
diamonds %>% 
  ggplot(mapping = aes(price)) +
  geom_histogram()

#Scatter and line plot showcasing carat by price
diamonds %>% 
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_point() +
  geom_smooth(color = "blue")

#Boxplot showcasing price by clarity
diamonds %>% 
  ggplot(mapping = aes(x = clarity, y = price)) +
  geom_boxplot()
  

#--------------------------------------------------------
#Question 2
#--------------------------------------------------------

#Carat
diamonds %>% 
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_bar(stat = "identity")

#Cut
diamonds %>% 
  ggplot(mapping = aes(x = cut, y = price)) +
  geom_bar(stat = "identity")

#Color
diamonds %>% 
  ggplot(mapping = aes(x = color, y = price)) +
  geom_bar(stat = "identity")

#Clarity
diamonds %>% 
  ggplot(mapping = aes(x = clarity, y = price)) +
  geom_bar(stat = "identity")

#Cut is the best predictor of price, because the quality of the cut and price rise together.

#--------------------------------------------------------
#Question 3
#--------------------------------------------------------

#Scatter and line plot showcasing carat by price bin
diamonds %>%
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
    ) %>% 
  ggplot(mapping = aes(x = price_binned, y = carat)) +
  geom_boxplot()

#Facet wrapped scatter and line plots showcasing carat by price bin across different diamond cuts
diamonds %>%
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  ) %>% 
  ggplot(mapping = aes(x = price_binned, y = carat)) +
  geom_boxplot() +
  facet_wrap(~ cut, nrow = 2)

#Facet wrapped scatter and line plots showcasing carat by price bin across different diamond color
diamonds %>%
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  ) %>% 
  ggplot(mapping = aes(x = price_binned, y = carat)) +
  geom_boxplot() +
  facet_wrap(~ color, nrow = 2)
  
#Facet wrapped scatter and line plots showcasing carat by price bin across different diamond clarity
  diamonds %>%
    filter(!is.na(carat), !is.na(price)) %>%
    mutate(
      price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                         dig.lab = 10)
    ) %>% 
  ggplot(mapping = aes(x = price_binned, y = carat)) +
    geom_boxplot() +
    facet_wrap(~ clarity, nrow = 2)
  
  
#Histograms of diamonds by carat, facetting using price bins
  diamonds %>% 
    filter(!is.na(carat), !is.na(price)) %>%
    mutate(price_binned = cut(price, 
                              breaks=c(seq(0, max(price), 5000), Inf), 
                              dig.lab=10)) %>%
    ggplot(., aes(x=carat, fill=price_binned)) + 
    geom_histogram(bins=50, show.legend = FALSE) + 
    facet_wrap(~ price_binned, scales = 'free_y', ncol = 1)

