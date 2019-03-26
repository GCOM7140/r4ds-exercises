library(tidyverse)

#Q1 Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
#Nothing in the grey canvas

#Q2 Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
#Boxplot gives more information on the data's range and median

#Q3 What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
ggplot(data = mpg, aes(x = class, y = drv)) +
  geom_point()
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
# The previous one is not useful because the graph are simply provides points without any additional information provided, and they are ordered by their categories. The bar chart is more effectively because we can see the compostion percentage of each graph. 

#Q4 What geom would you use to draw: A line chart? A boxplot? A histogram? An area chart?
geom_line()
geom_boxplot()
geom_histogram()
geom_area()


#Q5 Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#The charts looks the same. In the first ggplot, "data = mpg, mapping = aes(x = displ, y = hwy)" is used for all functions; in the second ggplot, it was written separately in two functions






