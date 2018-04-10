#' --- 
#' title: "r4ds exercise 2" 
#' author: Amelia Nelson
#' date: April 3, 2018 
#' output: github_document 
#' ---

library(tidyverse)
?mpg

# Question 1: Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

# This code produces an empty graph because we have not specified what to plot yet; we have only specified the data set to pull from. 

# Question 2: Make a scatterplot of cyl vs displ, then make a boxplot with the same variables. What additional information does the boxplot convey?

# scatterplot 
ggplot(data = mpg, aes(x = cyl, y = displ)) +
  geom_point()

# boxplot
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# Both plots use the same data and show that as the number of cylinders in a car increases, the engine displacement in liters also increases. However, the boxplot provides more detail than the scatterplot. It shows The median and quartile values as well any outliers while the scatterplot only shows the range of values. 

# Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(data = mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(data = mpg) +
  geom_bar(
    mapping = aes(x = class, fill = drv),
    position = "fill"
    )

# The scatterplot is not useful because we can't tell the proportion of cars that fall in each category (i.e. no quantitative data is shown). A bara chart fixes the problem. 

# Question 4: What geom would you use to draw: A line chart? A boxplot? A histogram? An area chart?

# line chart: geom_line()
# boxplot: geom_boxplot()
# histogram: geom_histogram()
# area: geom_area() or geom_bar()

# Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# They do not look different. The first method is just less repetitve because the layers can absorb the mapping arguements specified in ggplot()