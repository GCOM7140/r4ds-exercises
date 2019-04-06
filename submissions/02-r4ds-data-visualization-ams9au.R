# r4ds Data Visualization Exercises

library(tidyverse)
library(nycflights13)


#Question 1: Run `ggplot(data = mpg)`. What do you see?  

ggplot(data = mpg)
#The bottom right plot corner has become completely blank/grey.

#Question 2: Make a scatterplot of `cyl` vs `displ`. Then, make a boxplot with the same variables. What additional information does the boxplot convey? Hint: Use `as.factor(cyl)` while specifying the boxplot.

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

#A positive relationship between cyl and displ. It also seems like this relationship is not completely linear, that is, 'displ' increases more than 'cyl' increases.

#Question 3: What happens if you make a scatterplot of `class` vs `drv`? Why is the plot not useful? Create an alternative visualization that displays the data more effectively. Hint: Use `geom_bar()` with `position = "fill"`. `geom_bar()` is covered in [Section 3.8][3.8].

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#The scatterplot does not make any kind of relationship very clear. By using coloirs the bar chart shows the proportion of class and drv much more obvious.

#Question 4: What geom would you use to draw: A line chart? A boxplot? A histogram? An area chart? 

# - geom_line()
# - geom_boxplot()
# - geom_histogram()
# - geom_area() or geom_bar()

#Question 5: Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#They do not appear different.