library(tidyverse)
library(ggplot2)
data(mpg)


#Question 1: Run ggplot(data = mpg). What do you see?

#We developed this question based on the first exercise in section 3.2.4 of R4DS. It is designed to get you thinking about visualizations with ggplot() from the ground (i.e., canvas) up.

ggplot(data = mpg)

#Nothing because it is simply setting the coordinate axis with the mpg dataset


#Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

#Hint: Use as.factor(cyl) while specifying the boxplot.

#Scatter Plot:
ggplot(mpg) +
  geom_point(mapping = aes(x = cyl, y = displ))

#Box Plot:
ggplot(mpg) +
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = displ))

#The box plot show the additional inofrmation of the point average, and standard deviation.


#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

#Hint: Use geom_bar() with position = "fill". geom_bar() is covered in Section 3.8.

ggplot(mpg) +
  geom_point(mapping = aes(x = class, y = drv))

#This plot is not useful becuase it plots a catagorical variables (drv and class) against eachother. A better plot would be a side-by-side bar chart:

ggplot(mpg) +
  geom_bar(mapping = aes(class, fill = mpg$drv), position = "fill")


#Question 4: What geom would you use to draw:

#A line chart? --> geom_point
#A boxplot? --> geom_boxplot
#A histogram? --> geom_histogram()
#An area chart? --> geom_area()


#Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#They will look exaclty the same because the top equation places the data and aes in the ggplot() command, which applies it to the entire plot. The second plot does the exact same.This does it by assigning the data and the aes to each geom.

