#Data Visualization Exercise - r4ds
#Yuansong(Kevin) Wu

library(tidyverse)
library(completejourney)

#Q1
ggplot(data = mpg)

#It's an empty graph


#Q2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

#The second graph adds more details such as medians, outliers and range in addition to the first graph.


# Q3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#The second graph effectively shows the proportion of combination.


# Question 4
geom_line()
geom_boxplot()
geom_histogram()
geom_area()


# Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# Those two are the same because each one enters the argument in either the global environment or the local environment, which have the same effect.