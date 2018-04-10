library(tidyverse)
library(completejourney)
hist(quantity)

#Question 1#
ggplot(data=mpg)
#nothing appears since no aesthetics have been added to the code.

#Question 2: Use a line graph to plot total sales value by day. What, if anything, do you find unusual about this visualization?#
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

#What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.#
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#Question 4: What geom would you use to draw:#
geom_line()
geom_boxplot()
geom_histogram()

#Question 5: Will these two graphs look different? Why/why not?#
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
