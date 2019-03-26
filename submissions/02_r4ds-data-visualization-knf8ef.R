#####################################
### GCOM 7140 (Customer) ############
### Data Transformation Exercises ###
### R4DS, Chapter 3               ###
### 3/26/19                       ###
#####################################


### file name: 02_r4ds-data-visualization-knf8ef.R

library(tidyverse)


### Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

# The command creates a blank plot since there are no aesthetics added to the code.


### Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

# Scatterplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = cyl, y = displ))

# Boxplot
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_point() +
  geom_boxplot()
# The boxplot also shows outl1iers within the data.


### Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

# Scatterplot
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = class, y = drv))
# This plot is not useful because it is more beneficial to see the data presented within groups.

# Alternative visualization
ggplot(data = mpg, aes(x = class, fill = drv)) + 
  geom_bar(position = "fill")


### Question 4: What geom would you use to draw:
##    A line chart? geom_line()
##    A boxplot?  geom_boxplot()
##    A histogram?  geom_histogram()
##    An area chart?  geom_bar()


### Question 5: Will these two graphs look different? Why/why not?

# No, these graphs will be identical. The first code is telling R to apply the functions geom_point and geom_smooth to the parameters set in the ggplot function. The second code does the same thing, but tells R to first run the ggplot geom_point function to a set of parameters, then to run the ggplot function geom_smooth to the a set of parameters. Since the two sets of parameters are the same, it will result in the same plot as the first code.