####### Rosemary O'Hagan ###########    
####### Customer Analytics HW #2 ###
####### 4/3/18 ####################

library(tidyverse)


################################################################################
################################################################################
# Question 1. Run ggplot(data = mpg). What do you see?

ggplot(data = mpg) #Nothing... need aesthetics?

################################################################################
################################################################################
# Question 2. Make a scatterplot of cyl vs displ, then make a boxplot with the 
# same variables. What additional information does the boxplot convey?

mpg %>% 
  ggplot() +
  geom_point(mapping = aes(x = cyl, y = displ))

mpg %>% 
  ggplot() +
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = displ)) 
##### Boxplots show greater details... 

################################################################################
################################################################################
# Question 3. What happens if you make a scatterplot of class vs drv? Why is the
# plot not useful? Create an alternative visualization that displays the data 
# more effectively.

mpg %>% 
  ggplot() +
  geom_point(mapping = aes(x = class, y = drv)) # No proportions shown.

mpg %>% 
  ggplot() +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

################################################################################
################################################################################
# Question 4. What geom would you use to draw: A line chart? A boxplot? 
# A histogram? An area chart?

# geom_line()
# geom_boxplot()
# geom_histogram()
# geom_area()

################################################################################
################################################################################
# Question 5. Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# No, they are asking for the same thing just designate parameters in different 
# spots.
