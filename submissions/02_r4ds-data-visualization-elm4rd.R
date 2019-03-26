library(tidyverse)
#Question 1
ggplot(data = mpg)
#I see a blank graph that looks like a big grey box

#Question 2
ggplot(data = mpg, aes(x = cyl, y = displ)) + geom_point()

ggplot(data = mpg, aes(x = cyl, y = displ)) + geom_boxplot()

#The boxplot displays more detail by including medians, IQ ranges and outliers

#Question 3
ggplot(mpg, aes(x = class, y = drv)) + geom_point()
ggplot(mpg) + geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
#The scatterpot plots too many observations in the same space, so it's hard to gauge proportions 

#Question 4
#geom_line
#geom_boxplot
#geom_histogram
#geom_area

#Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#The graphs are the same 