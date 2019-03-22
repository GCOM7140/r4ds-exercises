library(tidyverse)

#' Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
#' I see a blank grey square that will eventually become the plot once points are added 

#' Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data=mpg) +
  geom_point(mapping = aes(x=cyl, y=displ))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x= as.factor(cyl), y=displ))

#' Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data=mpg) +
  geom_point(mapping = aes(x=class, y=drv))
#' this scatterplot does not give much information about the relationship

ggplot(data=mpg) +
  geom_bar(mapping = aes(x=class, fill=drv), position = "fill")

#' Question 4: What geom would you use to draw:
#' A line chart?
#' geom_line()
#' A boxplot?
#' geom_boxplot()
#' A histogram?
#' geom_histogram()
#' An area chart?
#' geom_area()


#' Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#' these two graphs will not look different becauset the first one is just passing the set of mappings to ggplot instead of having to repeat it at a local layer 