library(tidyverse)

#1
ggplot(data = mpg)

# A grey box shows up in plots.

#2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# Rather than showing all of the individual points, the boxplot shows the median and IQRs of the points, along with outliers.

#3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# The scatterplot fails to show the proportion of observations.

#4

# Line chart
geom_line()

# Boxplot
geom_boxplot()

# Histogram
geom_histogram()

# Area chart
geom_area() or geom_bar()

#5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# The graphs are the same because the codes ask for the same thing. However, the first is simpler because the point and smooth functions recognize the same arguments as the ggplot function.