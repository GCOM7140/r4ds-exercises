library(tidyverse)

#Question 1: Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)
#I dont see anything show up except for a grey box because there is no diection on the ggplot in terms of what to show up on the plot. Now the ggplot just created a window for future plots


#Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?
ggplot(data = mpg, aes(x=cyl, y=displ))+
  geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

#The scarlett plot shows positive relationship between cyl and displ, and the boxplot shows this relationship in details in terms of median, range and outlier points.


#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#the scartterport plots varaibles in same coordinate, so the detailed qualities cannot be observed. 

#Question 4: What geom would you use to draw:
#A line chart? geom_line()
#A boxplot? geom_boxplot()
#A histogram? geom_histogram()
#An area chart? geom_area() or geom_bar()


#Question 5: Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#They look the same. 