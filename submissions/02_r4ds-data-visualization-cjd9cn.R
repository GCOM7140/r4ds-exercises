#############################
# Chris Dowdy March 26      #
# r4ds                      #
# Data Visualization        #
#############################

library(tidyverse)

# Question 1: Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

# I see nothing but an empty graph on the plot tab.

# Question 2: Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# the box plot gives more detail with where the mean and quartile ranges lie for
# each cylinder class

# Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# the first plot is not very useful becuase the propotions are hard to visualize
# the second plot gives a better picture of how each propotion for the different
# classses use differnt forms of drive (4 wheel, front, or rear)

# Question 4: What geom would you use to draw:

# A line chart?   geom_line()
# A boxplot?      geom_boxplot()
# A histogram?    geom_histogram()
# An area chart?  geom_area()

# Question 5: Will these two graphs look different? Why/why not?

# The following code runs the same graphs but the second one uses redundant data arguments becasue they can be added in the begining rather than for each if they are going to be the same.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

