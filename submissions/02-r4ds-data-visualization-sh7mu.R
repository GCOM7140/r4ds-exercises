library(tidyverse)

#' Q1 - Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

#'  This function produces a plain grey box with nothing inside
  

#' Q2 - Make a scatterplot of cyl vs displ. Then, make a boxplot with the same
#' variables. What additional information does the boxplot convey?
 
ggplot(aes(cyl, displ), data = mpg) + 
  geom_point()

ggplot(aes(as.factor(cyl), displ), data = mpg) +
  geom_boxplot()

#' The box plot shows the median and quartile ranges in the relationship between
#' cylinders and engine displacement. It also shows which data points are
#' outliers, which the regular scatterplot does not show


#' Q3 - What happens if you make a scatterplot of class vs drv? Why is the plot
#' not useful? Create an alternative visualization that displays the data more
#' effectively.
 
ggplot(aes(class, drv), data = mpg) + 
  geom_point()

#' This plot does not convey any real important information because just using
#' points on the graph that is not meant to show a relationship is ineffective.
 
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#' This bar chart conveys the required information effectively.
 

#' Q4 - What geom would you use to draw:
#' A line chart?
geom_line()

#' A boxplot?
geom_boxplot()

#' A histogram?
geom_histogram()

#' An area chart?
geom_area, geom_bar()
    

#' Q5 - Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
    
#' The two graphs will look the same. This is because if no argument is
#' specified in the geoms, they will take the argument from the ggplot line.
#' However, if none is specified in the ggplot line, the geoms must contain
#' arguments.
