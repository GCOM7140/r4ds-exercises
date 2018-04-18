# Molly Xie
# HW2

library(tidyverse)
library(ggplot2)
?mpg

# Question 1
ggplot(data = mpg)
# I saw nothing is being print out, only the grey box.

# Question 2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
# boxplot tell where the mean is, the 1st and 3rd quartile, and outliers.

# Question 3
ggplot(data = mpg, aes(x = class, y = drv)) + 
  geom_point()
# because the points are discrete, there is not much information to draw.
ggplot(data = mpg) + 
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")


# Question 4
geom_line()
geom_boxplot()
geom_histogram()
geom_area()


# Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# These two graphs look the same, because they are basically calling the same geom function with the same variable.