library(tidyverse)
?mpg

#Question 1
ggplot(data = mpg)
# I see nothing on the graph

# Question 2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()
# There is a positive correlation between cyl and displ
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
# The box plots have more information such as medians, quartiles and outliers

# Question 3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
# This plots overlapping observations

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# Question 4
geom_line()
geom_boxplot()
geom_histogram()
geom_area() or geom_bar()

# Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# The first one is more effeicent because it uses less code and allows for more flexibility