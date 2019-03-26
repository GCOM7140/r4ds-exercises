library(nycflights13)
install.packages("tidyverse")
library(tidyverse)

#Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

#A blank chart

#Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
# the boxplot shows the same as the scatterplot but with more details

#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
#Many coordinates are in similar placed so it is hard to read. The bar chart is easier to read.

#Question 4: What geom would you use to draw:
#A line chart?
geom_line()
#A boxplot?
geom_boxplot()
#A histogram?
geom_histogram()
#An area chart?
geom_area()

#Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#These graphs look the same but the first is better because it puts data and mapping in ggplot
