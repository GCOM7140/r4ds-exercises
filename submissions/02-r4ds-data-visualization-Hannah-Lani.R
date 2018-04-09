#' ---
#' Title: R4DS HW 2
#' Date:  April 3, 2018
#' Who:   Lani Hannah 
#'--- 

library(tidyverse)
library(ggplot2)

#' Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
#' I don't see anything. It's just an empty box. 

#' Question 2: Make a scatterplot of cyl vs displ, then make a boxplot with the same variables. What additional information does the boxplot convey?
#scatterplot
ggplot(data = mpg, aes(x = cyl, y = displ)) + geom_point()

#' boxplot: the boxplot displays quartiles, medians, and outliers for each type of ' cylinder. The relationship between engine displacement and cylinders and is more  clear with this visual.
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + geom_boxplot()

#' Question 3: What happens if you make a scatterplot of class vs drv? Why is the    plot not useful? Create an alternative visualization that displays the data more effectively. 
#' The first scatterplot is not useful because it is difficult to see any relationship between the car class and type of drive. 
ggplot(mpg, aes(x = class, y = drv)) + geom_point()

ggplot(mpg) + geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#' Question 4: What geom would you use to draw: A line chart? A boxplot?                A histogram? An area chart?

geom_line()
geom_boxplot()
geom_histogram()
geom_area()

#' Question 5: Will these two graphs look different? Why/why not?
#' These two graphs are the same. The first method is the simplest one and more straightforward because the data is specified in the ggplot function instead of     the other function. The second method is a bit redundant. 
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
  
  


