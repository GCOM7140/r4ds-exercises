library(tidyverse)

#Q1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)
#It is an empty gray graph

#Q2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
# The scatterplot indicates that cyliners and engine displacement are positively related. The boxplots gives more deails, such as quartiles. 

#Q3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
ggplot(mpg, aes(x = class, y = drv)) +geom_point()
ggplot(mpg) +geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
#It is easier to observe the relationship between class and drv in the bar chat since there are different colors and dimensions. 


#Q4: What geom would you use to draw:

#A line chart?
#A boxplot?
#A histogram?
#An area chart?

# line chart: geom_line()
# boxplot: geom_boxplot()
# histogram: geom_histogram()
# area chart: geom_area() or geom_bar()

#Q5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#The graphs look the same. These are just two different methods to specify and map the graph.