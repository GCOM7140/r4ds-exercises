#Customer Analytics
#Due Date: 3 April 2018


#-----------------------------------------------------------------------------
#Assignment 2 - R4DS Exercise
#-----------------------------------------------------------------------------

library(tidyverse)
?mpg
mpg

#-----------------------------------------------------------------------------
#Question 1
#-----------------------------------------------------------------------------

ggplot(data = mpg)
#The plots view is empty, because no functions, aesthetics, etc. have been added in yet. 

#-----------------------------------------------------------------------------
#Question 2
#-----------------------------------------------------------------------------

ggplot(data = mpg) +
  geom_point(mapping = aes(x = cyl, y = displ))

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = displ))

#The boxplot adds the full range of values by each value of cyl, expressed by the lines sticking out of each box. The thick line in the middle of each box represents the median y-axis value for that specific x-axis value. Finally, the boxes represent the likely range of variation of y-axis values for each x-axis value. 

#-----------------------------------------------------------------------------
#Question 3
#-----------------------------------------------------------------------------

ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv))
#It doesn't work properly because class and drv have non-numeric values. 

ggplot(data = mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#-----------------------------------------------------------------------------
#Question 4
#-----------------------------------------------------------------------------

#A line chart
ggplot() +
  geom_line()

#A boxplot
ggplot() +
  geom_boxplot

#A histogram
ggplot() +
  geom_histogram()

#An area chart
ggplot() +
  geom_area()

#-----------------------------------------------------------------------------
#Question 5
#-----------------------------------------------------------------------------

#Yes, these two graphs will look the same. Setting the data set and mapping standards in the ggplot function applies those to all following geom functions. However, you can use different mapping across the geom functions if you wish. 
