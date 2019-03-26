#title: "Data Visualization Exercises"
#output: github_document

library(ggplot2)
library(tidyverse)
#install.packages("tidyverse")
#install.packages("glue")
library(glue)

###Question 1
ggplot(data = mpg)
#A blank white plot

###Question 2
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + geom_boxplot()

###Question 3
ggplot(mpg, aes(x = class, y = drv)) + geom_point()


ggplot(mpg) + geom_bar(mapping =aes(x=class, fill =drv), position = "fill")
#The bar plot makes it easier to visualize what the data is actually saying

###Question 4
geom_line()
geom_boxplot()
geom_histogram()
geom_area()
geom_bar()

###Question 5
#they should produce the same graphs. I do not see why the would not. One might be a little simpler than the other from a code perspective

ggplot(data = mpg, mapping = aes(x = displ, y =hwy)) + 
  geom_point() +
  geom_smooth()

ggplot() +
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))




