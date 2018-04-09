library(tidyverse)


#Q1
ggplot(data=mpg)
#I see an empty graph.

#Q2

ggplot(data = mpg, aes(x = cyl, y = displ)) + geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + geom_boxplot()

#Q3

ggplot(mpg, aes(x = class, y = drv)) + geom_point()

#Doesn't gIve me anything I could understand.

ggplot(mpg) +geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#Q4

geom_line()
geom_boxplot()
geom_histogram()
geom_area() 

#Q5

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
