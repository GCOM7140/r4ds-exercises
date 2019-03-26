# ++++++++++ r4ds Data Visualization Exercises ++++++++++

library(tidyverse)

# Question 1: Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

# All this returns is a blank canvas. 

# Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = displ))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = displ))

# The boxplot helps better visualize engine size based on the number of cylinders as categories. We are able to see median values as well as upper and lower quartiles, etc. 

# Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))

# The scatterplot is not useful because not only is it hard to interpret, but we cannot derive any meaningful relationships between the variables because they are both categorical. 

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# Question 4: What geom would you use to draw:

  # A line chart? - geom_line()
  # A boxplot? - geom_boxplot()
  # A histogram? - geom_histogram()
  # An area chart? - geom_area() or geom_bar

# Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# The graphs will look the same, but the first one is more efficient in terms of code. The key takeaway here is that objects can have different mappings, which allows for flexibility across layers of visualizations.