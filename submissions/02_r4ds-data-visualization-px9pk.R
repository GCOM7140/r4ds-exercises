# Name: Pan Xiao
# Assignment: R4DS-exercise
# Date: Mar 25, 2019


# Question 1: 
# Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)
# There is an empty graph in the plot panel.

# Question 2: 
# Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = displ))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = displ))
# In comparison to the scatter plot, the boxplot tells additional information about the medians, interquartile ranges and outliers. 

# Question 3: 
# What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))
# The plot does not tell the number of each class or type of wheel drive. 

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv))

# Question 4: 
# What geom would you use to draw:

# A line chart: geom_smooth()
# A box plot: geom_boxplot()
# A histogram: geom_histogram()
# An area char: geom_bar()

# Question 5: 
# Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# The two graphs are the same since the data source and information in the ggplot apply to all the functions as followed

















