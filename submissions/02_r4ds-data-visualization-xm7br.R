library(tidyverse)
library(ggplot2)

####
#Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

#I see the visualization pane automatically jummps to the plot tab and creates a blank gray canvas. 

####
#Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

#creating scatterplot
ggplot(data = mpg)+
  geom_point(mapping = aes (x = cyl, y = displ))

#creating boxplot
ggplot(data = mpg)+
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = displ))

#or use the group = function
ggplot(data = mpg)+
  geom_boxplot(mapping = aes(group = cyl, y = displ)
               
####
#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))
#this scatterplot is not useful because both of these variables are categorical, not continuous. Creating a scatterplot only maps out the coordinates of each datapoint without further information such as counts

#An alternative way to creat this chart is to create a bar chart 
ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv),position = "fill")

####
#Question 4: What geom would you use to draw:
  #A line chart?
  #A boxplot?
  #A histogram?
  #An area chart?

geom_line()
geom_boxplot()
geom_histogram()
geom_area()

####
#Question 5: Will these two graphs look different? Why/why not?

#ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  #geom_point() + 
  #geom_smooth()

#ggplot() + 
  #geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  #geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

##These two plots will look the same. They only differ in where they define the data frame. 
