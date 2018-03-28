#############
# FILE INFO #
#############

# Title: GCOMM 7140 Homework 2
# Author: Noah Rodammer


#################
# LOAD PACKAGES #
#################

library(tidyverse)
library(dplyr)
library(devtools)
library(ggplot2)

?mpg

####################
#  R4DS EXERCISES  #
####################


#################
#  QUESTION #1  #
#################

#Run ggplot(data = mpg). What do you see?

##This question is 3.2.4.#1 and grows your ability to create the ggplot() canvas
##(link).

ggplot(data=mpg)

##If you don't add anything else, all you see is a gray screen. It doesn't have any plots which would be there.


#################
#  QUESTION #2  #
#################

#Make a scatterplot of cyl by displ, then make a boxplot to visualize the data. 
#What additional information does the boxplot convey?  

##Hint: Use as.factor(cyl) when generating the boxplot. This question is based 
##on 3.2.4.#4 and grows your ability to plot a continuous variable by 
##categorical variable (link).

mpg %>%
  ggplot() +
geom_point(mapping = aes(x = cyl , y = displ)) 

mpg %>%
  ggplot() +
  geom_boxplot(mapping = aes(x=as.factor(cyl),displ))



#################
#  QUESTION #3  #
#################

#What happens if you make a scatterplot of class vs drv? Create an alternative 
#visualization that better conveys the information. 

## Hint: Use geom_bar() with position="fill". Using geom_bar() is covered in
##3.8. This question is based on 3.2.4.#5 and grows your ability to plot two 
##categorical variables (link).

mpg %>%
  ggplot() +
  geom_point(mapping = aes(x = class , y = drv))

mpg %>%
  ggplot() +
  geom_bar(mapping = aes(x = class, fill=drv),position="fill")



#################
#  QUESTION #4  #
#################
#What geom would you use to draw:
#A line chart?
##geom_line

#A boxplot?
##geom_boxplot

# A histogram?
##geom_histogram

# An area chart?
##geom_area()



#################
#  QUESTION #5  #
#################

# Will the graphs created by the two code blocks below look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

##Yes, the code displays the same thing, because the data and mapping carry through if it is used as an argument for ggplot. 