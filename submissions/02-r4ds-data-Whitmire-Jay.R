##### Jay Whitmire

knitr::opts_chunk$set(echo = TRUE)

library(tidyverse)

# Question 1: Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

#I see a grey square with nothing to it.  basically a blank graph

# Question 2: Make a scatterplot of cyl vs displ, then make a boxplot with the same variables. What additional information does the boxplot convey?

mpg %>% 
  ggplot() +
  geom_point(aes(x = cyl, y = displ))

mpg %>% 
  ggplot() +
  geom_boxplot(aes(x = cyl, y = displ, group = cyl))

mpg %>% 
  ggplot() +
  geom_boxplot(aes(x = as.factor(cyl), y = displ))

# the box plot shows the mean and quartiles

# Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

mpg %>% 
  ggplot() +
  geom_point(aes(x = class, y = drv))

?mpg

# this displays which classes have which options for which wheels do the driving.  I wouldn;t say its not useful, if you want to know if a car had class has a drv in the data this shows that.  But this masks the number of cars for eachpoint.

mpg %>% 
  ggplot() +
  geom_bar(aes(x = class, fill = drv))

# Question 4: What geom would you use to draw:

#  A line chart?

mpg %>% 
  ggplot() +
  geom_smooth(aes(x = displ, y = hwy))

#  A boxplot?

geom_boxplot()

#  A histogram?

geom_histogram()

#  An area chart?
mpg %>% 
  ggplot() +
  geom_area(aes(x = hwy, y = class))

# Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Nop they do not look different.  it just has to do with which place you put the information on aesthetic but it doesn;t effect the outcome
