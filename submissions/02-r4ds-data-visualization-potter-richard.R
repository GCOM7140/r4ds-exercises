# Richard Potter
# Data Visualization R4DS Homework Assignment
# Professor Boichuk
# 3 April 2018


# Opening Information -----------------------------------------------------
library(tidyverse) #Loading Tudyverse
library(ggplot2) #Loading GGPlot

# Question 1 --------------------------------------------------------------
View(ggplot2::mpg)
# This results in a tibble, demonstrating the data without any visualizations.
# The data are sorted alphabetically by manufacturer, then model, then 
# displacement.
  
# Question 2 --------------------------------------------------------------

mpg %>% 
  ggplot() +
  geom_point(aes(cyl, displ))

mpg %>% 
  mutate(cyl = as.factor(cyl)) %>% 
  ggplot() +
  geom_boxplot(aes(cyl, displ))

# Question 3 --------------------------------------------------------------
mpg %>% 
  ggplot() +
  geom_point(aes(class, drv))
# This plot is not useful as it plots two categorical variables against each
# other, and does not show anything other than the presence of vehicles which
# fit the required intersection. We do not know anything about the information
# contained in the points, such as frequency.

mpg %>% 
  ggplot() +
  geom_bar(aes(class, fill = drv), position = "fill")

# Question 4 --------------------------------------------------------------
# A line chart: geom_line
# A boxplot: geom_boxplot
# A histogram: geom_histogram
# An area chart: geom_area

# Question 5 --------------------------------------------------------------
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
geom_point() +
geom_smooth()
                                          
ggplot() +
geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# These two graphs will have the same result. In the first, the variables are
# considered as part of the master options, as they are part of the ggplot
# option, and are then inherited by the geometry. Only because the exact same
# options are later placed under the geometries, and they are the exact same,
# then we can have them be the same plot.