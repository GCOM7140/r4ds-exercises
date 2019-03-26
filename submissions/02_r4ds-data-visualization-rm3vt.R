# Name: Roy MAsha
# Assignment: Data Visualization NYC Flights Data 

library(tidyverse)
 
#' Question 1: Run ggplot(data = mpg). What do you see?
#' I see a blank plot in the plot column. I can use it to fill in graph features.

ggplot(data = mpg)

#' Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, aes (x =cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes (x =as.factor(cyl), y = displ)) + 
  geom_boxplot()

#' The boxplot shows greater detail in the relationship between number of cylinders and engine displacement. You can see the median, quartile ranges and any outliers that exist, while with a scatterplot you can only see the general trend. 

#' Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg, aes (x =class, y = drv)) + 
  geom_point()

ggplot(data = mpg) + 
  geom_bar(mapping = aes (x =class, fill = drv), position = "fill")

#' Question 4: What geom would you use to draw:
#' The scatterplot puts many observations on the same plane, so it is difficult to gauge the relationship. 

#' Line chart- geom_line()
#' Boxplot- geom_boxplot()
#' Histogram- geom_histogram()
#' Area- geom_area()

#' Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#' No, the two graphs will not look different. This is because in the first code, the specific variabels are entered into the ggplot() code, while in the second, the variables are entered in their geom_point() and geom_smooth() components separately. 



