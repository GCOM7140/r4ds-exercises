library(tidyverse)
library(completejourney)

ggplot(data = mpg)
# you get a grey box running that control

#question 2

ggplot(data = mpg, aes(x = cyl, y = displ)) + geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
#the plot gives more information such as median , interquarle plots or outliers

#question 3

ggplot(mpg, aes(x = class, y = drv)) + geom_point()

ggplot(mpg) +geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#a bar chart conveys the information more usefely just because drv is a categorical variable.position fill allows as to see what proportion a car has in each category.

#question 4

#geom_line
#geom_boxplot
#geom_histogram
#geom_area

#question 5

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#they are identical, the first form is preferred as geom functions can import arguments from from the ggplot function.
