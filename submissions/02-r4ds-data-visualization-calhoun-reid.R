# Reid Calhoun
# R4DS HW #2
# Due March 3, 2018

library(tidyverse)
?mpg


##################
### Question 1 ###
##################

# Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)
  
# All I see is a grey canvas






##################
### Question 2 ###
##################


# Make a scatterplot of cyl vs displ, then make a boxplot with the same variables. # What additional information does the boxplot convey?

mpg %>% 
  ggplot(aes(cyl, displ)) +
  geom_point()

mpg %>% 
  ggplot(aes(as.factor(cyl), displ)) +
  geom_boxplot()
  
# The boxplot better conveys the median and quartiles for displ for each cyl







##################
### Question 3 ###
##################

# What happens if you make a scatterplot of class vs drv? Why is the plot not useful?
# Create an alternative visualization that displays the data more effectively.

mpg  %>% 
  ggplot(aes(class, drv)) +
  geom_point()
# This plot makes no sense because class and drv are categorical variables

mpg %>% 
  ggplot(aes(class, fill = drv)) +
  geom_bar(
    position = "fill"
  )







##################
### Question 4 ###
##################

# What geom would you use to draw:
#  A line chart?
geom_line()

#  A boxplot?
geom_boxplot()

#  A histogram?
geom_histogram()

#  An area chart?
geom_area()






##################
### Question 5 ###
##################

# Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# No, they will not look different. The exact same information is given to the console