# Justin Lagomarcino


library(tidyverse)

# Question 1 - Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

# I see a blank empty grey graph in my plots pane.

# Question 2 - Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()


ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# Both show a positive relationship between the cylinders and the overall displacement of the engine. The boxplot gives the same insight with some finer level statistical visuals. More specifically, the range and median of each cylinder level. Outliers are also displayed (see cylinder lvl 8). On average, when cylinder count increases by 2, the displacement increases a little under 1.5.

# Question 3 - What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg, aes(x = class, y = drv)) + geom_point()

# Multiple drv levels plotted for some class. Doesn't tell me much. Would be more helpful to see percent of each class that is 4, fw, rw drive.

ggplot(mpg) + geom_bar(mapping = aes(x = class, fill = drv), position = "Fill" )

# much more informative. Can see ratio of each class in respective to drv.

# Question 4 - What geom would you use to draw:

   # A line chart?
        # geom_line()
   # A boxplot?
        # geom_boxplot()
   #  A histogram?
        # geom_histogram()
   #  An area chart?
        # geom_area()

# Question 5 - Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# Produces the same plot. First command makes more sense because it clearly shows the data being plotted first and then tells ggplot which form of geom function to use to plot the visual. 
