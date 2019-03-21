library(tidyverse)

# Question 1

# Run ggplot(data = mpg). What do you see?

# Nothing. 

ggplot(data = mpg)

# Question 2

# Make a scatterplot of cyl vs displ. Then, make a boxplot with the same 
# variables. What additional information does the boxplot convey?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = displ))

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + geom_boxplot()

# The boxplot tells the interquartile range, mean, and outliers

# Question 3

# What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))

# There is limited variance in the data, and the data are categorical, so a bar 
# graph is better suited for analysis

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# Question 4

# What geom would you use to draw?

# A line chart 

geom_line()

# A boxplot?

geom_boxplot()

# A histogram?

geom_histogram()

# An area chart?

geom_area()

# Question 5

# Will these two graphs look different? Why/why not?

# The graphs will not look different, since the default setting remain the same across the commands
