#' --- 
#' title: "Data Visualization Exercises for r4ds"
#' author: Mo Jmaileh
#' date: April 3, 2018 
#' ---


knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)


#Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)  

#Question 2: Make a scatterplot of cyl vs displ, then make a boxplot with the same variables. What additional information does the boxplot convey?
ggplot(mpg, aes(as.factor(cyl), displ)) + 
  geom_point()
ggplot(mpg) + 
  geom_boxplot(aes(as.factor(cyl), displ))  
  
#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
ggplot(mpg, aes(class, drv)) + geom_point()
ggplot(mpg, aes(x = class, fill = drv)) + geom_bar(position = "fill")


#Question 4: What geom would you use to draw:
  
  #A line chart? 
#geom_smooth()

#  A boxplot?
#geom_boxplot()
#  A histogram?
#geom_histogram()
#  An area chart?
#geom_area()


Question 5: Will these two graphs look different? Why/why not?
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#They will not because you they both use the same grammer of graphics. The reason why they look different is because the data and mapping of aesthetics takes place in the ggplot section in the first lines of code, but the second just includes the same information in the geom_point and geom_smooth parameters. I prefer the first code because it contains the same informaiton without repition. 