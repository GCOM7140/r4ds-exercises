library(tidyverse)


# Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

# A grey box

# Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = displ))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = displ))

# you can see the differences in displ across the varying number of cylinders

# Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))

#hard to compare between class

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#Question 4:

geom_line()
geom_boxplot()
geom_histogram()
geom_area()

#Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#They don't look different. The first graph uses the global mapping settings for geom_point and geom_smooth














