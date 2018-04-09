library(tidyverse)
?mpg

# Question 1
ggplot(data = mpg)

# an empty graph


# Question 2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# The first graph is not useful because it only shows an overall relationship is positive between displ and cyl. The second graph shows more details with medians, outliers, range.


# Question 3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# For the first graph, it's hard to see the proportion of combination. The second graph shows it more effectively and conveys more information.


# Question 4
geom_line()
geom_boxplot()
geom_histogram()
geom_area()


# Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# They are the same. Because the first one enters the arguments into the global ggplot function, and the second one enters the arguments into two layers seperately. This will lead to the same result.