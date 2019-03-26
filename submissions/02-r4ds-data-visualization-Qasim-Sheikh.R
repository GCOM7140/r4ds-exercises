#Question 1: Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

#Nothing: the plot has been initialized but elements need to be added to it for it to display a plot. 

#Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, aes(x = cyl, y = displ)) + geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + geom_boxplot()

#The boxplot displays medians and percentiles

#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg, aes(x = class, y = drv)) + geom_point()
#this is not useful because the data should be displayed as a proportion, which this plot does not accomplish. 

ggplot(mpg) +geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#**Question 4**: What geom would you use to draw:

#- A line chart? 

#geom_line

# - A boxplot?

#geom_boxplot

#- A histogram?

#geom_histogram

#- An area chart?

#geom_bar

#Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#these plots will not look different because the same parameters are simply entered at different points of the script. 

