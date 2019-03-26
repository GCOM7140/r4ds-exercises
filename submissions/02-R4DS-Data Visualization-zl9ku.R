#------------------------------#
# Theme: Data visualization #
# Author: Roy Luo #
#------------------------------#

library(tidyverse)

# Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
# An empty graph as a grey area in the plots tab.

# Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

# scatter plot
ggplot(data = mpg, aes(x=cyl, y = displ)) +
  geom_point()
# box plot
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) +
  geom_boxplot()
# The scatter plot shows a positive relationship between #of cylinder used and engine displacemnt.However, box plot give more detailed information by median, interquartile range and even outliers. In this case, for every two cylinders, engine displacement increases by 1.5.

# Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
# drv has multiple categories and thus cause many observations in scatter plot, this should be changed to a bar graph
ggplot(mpg)+
  geom_bar(aes(x = class, fill = drv), position = "fill")

# Question 4:What geom would you use to draw:

# A line chart?
# A boxplot?
# A histogram?
# An area chart?

# Anwser：
# - geom_line()
# - geom_boxplot()
# - geom_histogram() 直方图
# - geom_area() or geom_bar()

# Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# they are identical, but the first method is more efficient, because it enters the `data` and `mapping/aes` arguments into the `ggplot()` function, while the second code enters twice. 









