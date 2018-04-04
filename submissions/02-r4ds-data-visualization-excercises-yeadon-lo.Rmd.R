---
title: "GCOM 7620 Lab Assignment 1"
author: "Lo Yeadon"
date: "April 3, 2018"
output:
  html_document: default
---
library(tidyverse)
?mpg  
  
#Question 1: Run ggplot(data = mpg). What do you see?
  
     #This question is 3.2.4 #1. It is designed to get you thinking about visualizations with ggplot() from the ground (i.e., canvas) up.

ggplot(data = mpg)

#No plat appears after running this command.

#Question 2: Make a scatterplot of cyl vs displ, then make a boxplot with the same variables. What additional information does the boxplot convey?
  
    #Hint: Use as.factor(cyl) while specifying the boxplot.

    #This question is based on 3.2.4#4. It is designed to strengthen your ability to plot a continuous variable by a categorical variable.

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

     #Hint: Use geom_bar() with position = "fill". geom_bar() is covered in Section 3.8.

    #This question is based on 3.2.4#5. It is designed to strengthen your ability to plot the joint distribution of two categorical variables.


ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#Question 4: What geom would you use to draw:
  
#A line chart?

geom_line()

#A boxplot?

geom_boxplot()

#A histogram?

geom_histogram()

#An area chart?
  
geom_area()

    #This question is 3.6.1#1. It is designed to strengthen your knowledege of the various ggplot() geom objects.

#Question 5: Will these two graphs look different? Why/why not?
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))


   #This question is 3.6.1#5. It is designed to strengthen your understanding of inheritence with respect to the ggplot() mapping argument.

#The two graphs appear to be exactly the same. However there is a variation in the code used to produced the graphs. The first graph is more efficient because the user input the "data", "mapping" and "aes" specifications into the parenthesis following the ggplot command. As a result the user who created graph one did not have to recopy this information in to the "geom_point" and "geom_smooth" parenthesis. Therefore this user did not risk altering the data at some point in the process.  
