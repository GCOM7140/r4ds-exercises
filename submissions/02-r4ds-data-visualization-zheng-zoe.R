#' ---
#' title: "Answers to the R4DS Data Visulization Exercise"
#' author: Zoe Zheng
#' date: April 3, 2018
#' output: github_document
#' ---

library(tidyverse)
library(ggplot2)
#' **Question 1**: Run `ggplot(data = mpg)`. What do you see?  
#'
ggplot(data = mpg)

#' There is nothing showed in the plots section.


#' **Question 2**: Make a scatterplot of `cyl` by `displ`, then make a boxplot to 
#'visualize the data. What additional information does the boxplot convey?

#' scatterplot of `cyl` by `displ`
ggplot(mpg, aes(cyl,displ)) + geom_point()

#' The scatterplot shows as the number of cylinders increases, the engine displacement
#' increases.
#' 
#' boxplot of `cyl` by `displ`
ggplot(mpg, aes(as.factor(cyl),displ)) + geom_boxplot()

#' The boxplot shows the similar information as scatterplot does. In addition, 
#' we can also see the distribution of data, such as minimum, maximum as well as 
#' median within each category.
#' 
#' 


#' **Question 3**: What happens if you make a scatterplot of `class` vs `drv`? 
#' Create an alternative visualization that better conveys the information.

ggplot(mpg, aes(class,drv)) + geom_point()
ggplot(mpg) + geom_bar(mapping=aes(x=class,fill=drv),position = "fill")

#' In the scatterplot, the relationship between type of car and whether the car is 
#' front-wheel/rear-wheel/four-wheel drive is not clear. Instead, it's better to use
#' a bar char to show the percentage of drive type within each car class.
#'  




#' **Question 4**:What geom would you use to draw:
#' - A line chart? 

'+geom_line()'

#' - A boxplot?

'+geom_boxplot()'

#' - A histogram?

'+geom_histogram()'

#' - An area chart?

'+geom_area()'


#' **Question 5**: Will the graphs created by the two code blocks below look different? 
#' Why/why not?


ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
 geom_point() +
 geom_smooth()

ggplot() +
 geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
 geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#' These two code blocks will generate same graphs. The first code block claims
#' the aes() in ggplot(), so that both geom_point() and geom_smooth() follows this 
#' aes; the second code block states aes() separately in both geom_point() and geom_smooth(), 
#' but these two methods have the same effect.