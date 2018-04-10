---
  title: "R4DS Exploratory Data Analysis"
author: "Lo Yeadon"
date: "April 2, 2018"
output:
  pdf_document: default
html_document: default
---
  install.packages("tidyverse")
  library(tidyverse)

#Exercise 1

  #Explore the distribution of price with geom_histogram() and other functions. Challenge yourself to go beyond the first plot you generate, which might might look something like this:
diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()

summary(diamonds$price)

  #Use prose to describe the distribution you utlimately discover. What are some of the most surprising features of the distribution to you?
  #Hint: It might help if you first view a quantitative assessment of the distribution with summary(diamonds$price).

#Answer 1: A vast majority of diamonds are below $5000, with a lot of diamonsds costing about $1000. When I ran "smmary(diamonds@price)" the output stated that the mean prce was $3933, but I am assuming that ths number is being pulled upwards by a low quantity of diamonds withvery high prices.
  


#Exercise 2

  #Which of the 4Cs (i.e., carat, cut, color, and clarity) is most important for predicting the price of a diamond?
  
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()

ggplot(diamonds, aes(x=clarity, y=price)) + 
  geom_point()

ggplot(diamonds, aes(x=color, y=price)) + 
  geom_boxplot()

ggplot(diamonds, aes(x=clarity, y=price)) + 
  geom_boxplot()

ggplot(diamonds, aes(x=cut, y=price)) + 
  geom_boxplot()

#Answer 2: Carat is most important for predicting the price of a diamond. This is demonstrated in the data because you can see a clear relationship between carat and price, where data increases as the number of carats increases. Conversely thhe differences between the categorical variables do not seem to have a clear relationship with diamnd price. 


#Exercise 3

  #Visualize the distribution of carat, partitioned by price. Then, after revisiting Faceting, use facet_wrap() to accomplish the same.

  #Hint: After binning price, plot the distribution of carat for each bin. Binning price can be accomplished with the following command:

  diamonds %>% 
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  )

  
#Answer #3: 
  diamonds %>% 
    filter(!is.na(carat), !is.na(price)) %>%
    mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                              max(price)), dig.lab=10)) %>%
    ggplot(., aes(price_binned, carat)) + 
    geom_boxplot()
  
#Aternative Answer #3:
  diamonds %>% 
    filter(!is.na(carat), !is.na(price)) %>%
    mutate(price_binned = cut(price, 
                              breaks=c(seq(0, max(price), 5000), Inf), 
                              dig.lab=10)) %>%
    ggplot(., aes(x=carat, fill=price_binned)) + 
    geom_histogram(bins=50, show.legend = FALSE) + 
    facet_wrap(~ price_binned, scales = 'free_y', ncol = 1)
  