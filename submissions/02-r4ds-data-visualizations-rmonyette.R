library(tidyverse)

# Question 1
ggplot(data = mpg)

# I see an empty graph

# Question 2

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# the boxplot removes outliers and shows how correlated certain points, gives a better idea of medians and max/min

# Question 3

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
# this creates a fantastic "connect the dots" board, easil sellable to restaurants 

ggplot(mpg, aes(x = class)) +
  geom_dotplot(alpha = .8, fill = "red", binwidth = .2, dotsize = .5 )

# Question 4

geom_line()
geom_boxplot()
geom_histogram()
geom_area()

# Question 5

# Graph 1
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

# Graph 2
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# I see no difference in these graphs. I assume R just attomatically fills in the defaults if one doesn't specifically change them
