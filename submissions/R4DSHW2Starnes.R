##Michael Starnes
## 2-4-2018
##R4DS Assignment 2



#Question 1
library(tidyverse)
?mpg
ggplot(data=mpg)
#Gray screen in the panel with no visualization included

#Question 2
ggplot (data=mpg,  aes(x = cyl, y= displ)) +
  geom_point()
# The boxplot shows that larger cylender engines have a greater displacement, although the displacement per cyl isn't necessarily the same at every cyl.

ggplot(data=mpg, aes(x = as.factor(cyl), y= displ)) + 
      geom_boxplot()
#This shows the median and range, as well as outliers.

#Question 3
  ggplot(mpg,  aes(x = class, y= drv))  +
    geom_point()
    #This shows the breakdown by car class, but it is really hard to see what this means because the way the data is displayed isn't very descriptive.
    ggplot(mpg) +
      
    geom_bar(mapping = aes( x = class, fill = drv),  position = "fill")
  #This breakdown with bars is much more clear because you are able to see what proportion of cars by class are each different classification of DRV.  For viewers, this communicates a lot more info than the first ggplot in this section.
  
#Question 4
  Geom Objects:
    
    #Line chart
    geom_line()
    #Boxplot
    geom_boxplot()
    #Histogram
    geom_histogram()
    #Area Chart
    geom_area()
    
#Question 5
    ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
      geom_point() + 
      geom_smooth()
    
    ggplot() + 
      geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
      geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
    
    #While both of these would result in the same ggplot, the components that make up the graph are different.  While the graphs are the same, the lines are defined differently.  Depending on one's objectives, the either way could be used.  This example is instructive because there are a lot of "right" ways to do things in R.

