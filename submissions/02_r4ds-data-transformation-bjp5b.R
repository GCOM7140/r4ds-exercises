#'---
#' title: "Data Visualization Solutions"
#' output: github_document
#' ---
  
library(tidyverse)

#' Question 1
ggplot(data = mpg) 
#' nothing comes up for thie plot since I haven't specifed any variables for the
#' program to plot on the X and Y axes.

#' Question 2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
#' the boxplot shows some additional details for the data (median, range and outliers).

#' Question 3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
#this plots multiple variables along the same axis, which makes reading the plot confusing
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
#this is simply a better way of visualizing this kind of information

#' Question 4

#' - geom_line()
#' - geom_boxplot()
#' - geom_histogram()
#' - geom_area() or geom_bar()

#' Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#' The two produce plots that look exactly the same visually, but the first one
#' does everything with less code and looks a lot cleaner/easier to read