# R4DS Exercises 2 - Data Visualization

library(tidyverse)

# Question 1

ggplot(data = mpg) # nothing is plotted; need aesthetics

# Question 2

ggplot(data = mpg) +
  geom_point(aes(cyl, displ))

ggplot(mpg) +
  geom_boxplot(aes(as.factor(cyl), displ)) # The boxplot gives distributions of displacement for each cylinder amount

# Question 3

ggplot(data = mpg) +
  geom_point(aes(class, drv))

ggplot(data = mpg) +
  geom_bar(aes(class, fill = drv), position = "fill") # This is better because it shows the makeup of drivetrains for each class

# Question 4

  # line: geom_line or geom_smooth
  # boxplot: geom_boxplot
  # histogram: geom_histogram
  # area chart: geom_area

# Question 5

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# They are not different; the difference in code comes to where the x and y are specified; using the second method would be beneficial if you were trying to plot a line through something else, like a regression model
