# Oliver Song os8ua

library(tidyverse)

# Question 1
ggplot(data = mpg) # empty graph

# Question 2
ggplot(data = mpg, aes(x = cyl, y = displ)) +
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) +
  geom_boxplot()


# Question 3
ggplot(mpg, aes(x = class, fill = drv)) +
  geom_bar(position = "fill")

# Question 4

## line chart: geom_line()
## boxplot: geom_boxplot()
## histogram: geom_histogram
## area chart: geom_area()

# Question 5

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# the graphs will be the same, the first one just stores the values as a global setting and automatically populates the empty parentheses for geom_point and geom_smooth.