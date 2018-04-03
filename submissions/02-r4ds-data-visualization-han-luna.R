#' ---
#' title: "Answers to the R4DS Data Transformation Exercise"
#' author: Luna Han
#' date: April 2, 2018
#' output: github_document 
#' ---
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
?mpg
#Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

#Question 2: Make a scatterplot of cyl vs displ, then make a boxplot with the same variables. What additional information does the boxplot convey?
#Hint: Use as.factor(cyl) while specifying the boxplot.
ggplot(mpg) + geom_point(mapping = aes( x = cyl, y = displ))
ggplot(mpg) + geom_boxplot(mapping = aes( x = as.factor(cyl), y = displ))

#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
#Hint: Use geom_bar() with position = "fill". geom_bar() is covered in Section 3.8.
ggplot(mpg) + geom_point(mapping = aes( x = class, y = drv))
ggplot(mpg) + geom_bar(mapping = aes( x = class, fill= drv))

#Question 4: What geom would you use to draw:
#A line chart?
geom_line()
#A boxplot?
geom_boxplot()
#A histogram?
geom_histogram()
#An area chart?
geom_area()

#Question 5: Will these two graphs look different? Why/why not?
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# Those two graphs are the same, because you can either put the data and mapping information in the global ggplot function, or into the geom_ fuctions seperately.