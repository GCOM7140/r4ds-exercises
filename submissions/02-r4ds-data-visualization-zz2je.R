library(tidyverse)

#Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
# I see a grey and empty canvas appearing at the Plot tab in the R Studio.


# Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?
ggplot(data=mpg)+
  geom_point(mapping=aes(x=cyl, y=displ)) 

ggplot(data=mpg)+
  geom_boxplot(mapping= aes(x=as.factor(cyl), y=displ))
# The boxplot also gives information about displ distribution across different cyl levels, specifically with infomration like interquartile values, medians, and outliers.


#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
ggplot(data=mpg)+
  geom_point(mapping=aes(x=class, y=drv)) 

ggplot(data=mpg)+
  geom_bar(mapping=aes(x=class, fill=drv),position = "fill") 
# The scatterplot is not useful because class and drv are two categorical variables while scatterplot is more designed more two continuous variables. So the plot is hard to convey information like counts of observations in each categories across two dimensions. Bar plot can do a better job in visualize such information.


#Question 4: What geom would you use to draw:
  # A line chart: geom_line()
  # A boxplot: geom_boxplot()
  # A histogram: geom_histogram()
  # An area chart: geom_area()


#Question 5: Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# These two graphs look identical.Because in the first graph, data and mapping is specified globally for the entire function while in the second graph, data and mapping is specified locally in each layer.
