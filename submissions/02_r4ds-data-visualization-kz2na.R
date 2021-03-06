library(lubridate)
library(tidyverse)

#Question 1: Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

#There is no plot showing up.

#Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

#The box plot conveys the medium, the non-overlapping interquartile range and outliers.

#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#The bar graph is much effective.

#Question 4: What geom would you use to draw:

# - geom_line()
# - geom_boxplot()
# - geom_histogram()
# - geom_area() or geom_bar()


#Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

## The graphs will be similar, although the first is more efficient, because it
# enters the `data` and `mapping` arguments into the global `ggplot()` function,
# whereas the second enters them into the `geom_point()` and `geom_smooth()`
# layers separately. Geometric objects inherit the `mapping` argument from the
# `ggplot()` command if it is specified. This example illustrates an important
# point: objects can have different mappings, which allows for a great deal of
# flexibility across layers of visualizations.