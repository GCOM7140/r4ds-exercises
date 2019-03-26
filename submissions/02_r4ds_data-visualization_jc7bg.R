library(tidyverse)
#Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
#nothing, a grey square.

#Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
#the boxplots display this relationship in greater detail with medians, interquartile ranges, and outlier points.

#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#Question 4: What geom would you use to draw:
#A line chart?
  #geom_line()
#A boxplot?
  #geom_boxplot()
#A histogram?
  #geom_histogram()
#An area chart?
  #geom_area() or geom_bar()

#Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# The graphs will be identical, although the first is more efficient, because it
# enters the `data` and `mapping` arguments into the global `ggplot()` function,
# whereas the second enters them into the `geom_point()` and `geom_smooth()`
# layers separately. Geometric objects inherit the `mapping` argument from the
# `ggplot()` command if it is specified. This example illustrates an important
# point: objects can have different mappings, which allows for a great deal of
# flexibility across layers of visualizations.