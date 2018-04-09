#' ---
#' title: R4DS Data Visualization Exercises
#' author: Kristina Kelhofer
#' date: April 3, 2018
#' ouptut: github_document
#' ---
#' ================
#' 
library(tidyverse)
#'
?mpg 
#'Question 1
ggplot(data = mpg)
#Mine isn't showing anything  

#'Question 2
mpg %>%
  ggplot(aes(cyl,
             displ)) + geom_point()

mpg %>%
  ggplot(aes(as.factor(cyl),
             displ)) + geom_boxplot()

# the boxplot adds the median, quartiles, and outliers

#'Question 3
mpg %>%
  ggplot(aes(class,drv)) + geom_point()

# this isn't very useful because the variables are discrete, and we do not see the magnitude of each point.

mpg %>%
  ggplot() + geom_bar(aes(fill = class, x = drv), position = "fill")
  
#'Question 4
ggplot() + geom_line()
ggplot() + geom_boxplot()
ggplot() + geom_histogram()
ggplot() + geom_area()

#'Question 5

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# These two graphs look the same, and reveal how the ggplot function works. Since both have the same inputs, we can put them in the general ggplot function and see no difference. If we wanted to make a change to one graph but not the other, we could add it to it's individual function.

