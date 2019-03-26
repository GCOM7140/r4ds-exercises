library(tidyverse)



# Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

# nothing. the code needs aesthetic mapping to display graphs. 
  

# Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(mpg,aes(cyl,displ))+
  geom_point()
ggplot(mpg,aes(as.factor(cyl),displ))+
  geom_boxplot()
# cars with 5 cylinders have much less variety. there are two outliers in 8-cylinder cars. The boxplot shows more clearly the increase of displ with number of cylinders.



# Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
ggplot(mpg,aes(class,drv))+
  geom_point()
#  the scatter plot only show points for the interception between class and drive, not much more useful information. 

ggplot(mpg,aes(x=class, fill = drv))+
  geom_bar(position = 'fill')
# if we want to count the occurence , a barchart may be mroe useful. 


# Question 4: What geom would you use to draw:
  
  # A line chart?
geom_line()
  # A boxplot?
geom_boxplot()
  # A histogram?
geom_histogram()
  # An area chart?
geom_bar()

# Question 5: Will these two graphs look different? Why/why not?
  
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# No. Because they used the same dataset with the same mapping. The mapping in the ggplot function serves as an overaching mapping for the plot
