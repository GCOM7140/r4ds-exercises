# Lucas Pulliza
# Homework Set 2, R4DS

library(tidyverse)
library(ggplot2)


#1 Run Graph
ggplot(data = mpg)
# It shows a blank graph...

#2 Scatterplot of cyl vs displ
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()
#boxplot shows additional information such as medians/interquartile ranges, essentially more specific

#3 What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

#4 this is self-explanatory..
geom_line() 
geom_boxplot()
geom_histogram()
geom_area()

#5 Will these graphs look different?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# No, they are identifical. The top gets this done with less code/more efficiently.
