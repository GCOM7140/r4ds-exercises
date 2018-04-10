#' George Homework # 2

library(tidyverse)

####' Question 1 ####
ggplot(data=mpg)
#' There is an empty graph. You have to add aes and a geom



####' Question 2 ####
ggplot(data = mpg, aes(cyl, displ)) +
  geom_point()

ggplot(data = mpg, aes(as.factor(cyl), displ)) +
  geom_boxplot()
#' The boc plot better explains the data by showing the outliers and interquartile ranges.



####' Question 3 ####
ggplot(data = mpg, aes(class, drv)) +
  geom_point()

ggplot(data = mpg, aes(class, fill = drv)) +
  geom_bar(position = "fill", color= "black", alpha = 0.8, size = 1)

#' The first plot does not show much, whereas the second one shows 
#' the percent breakdown of car type and drive type


####' Question 4 ####
#' line: geom_line
#' boxplot: geom_boxplot
#' histogram: geom_histogram
#' area chart: geom_area 

####' Question 5 ####
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#' They are the same, but the first is better because it will make chaning the geom easier

