<<<<<<< HEAD
library(tidyverse)

# Question1
ggplot(data = mpg)
# The output is a grey box.

# Question2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
# The scatterplot displays a positive relationship between cylinders and engine displacement. The boxplot shows more details: median, interquatile ranges and outliers. The median shows that for every two cylinders, engine displacement increases by about 1.5. 

# Question3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
# The scatterplot is not helpful because it plots many observations in the same (x, y) coordinate space, making it difficult to measure the proportion of observations for each combination while the bar chart makes it very clear. 


# Question 4
# A line chart - geom_line() 
# A box plot - geom_boxplot()
# A histogram - geo_histogram()
# An area chart - geom_area()


# Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# These two graphs look the same. The first one is more efficient because it enters the "data" and # "mapping" arguments into the global "ggplot()" function,
# whereas the second enters them into the "geom_point()" and "geom_smooth()"
=======
library(tidyverse)

# Question1
ggplot(data = mpg)
# The output is a grey box.

# Question2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
# The scatterplot displays a positive relationship between cylinders and engine displacement. The boxplot shows more details: median, interquatile ranges and outliers. The median shows that for every two cylinders, engine displacement increases by about 1.5. 

# Question3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
# The scatterplot is not helpful because it plots many observations in the same (x, y) coordinate space, making it difficult to measure the proportion of observations for each combination while the bar chart makes it very clear. 


# Question 4
# A line chart - geom_line() 
# A box plot - geom_boxplot()
# A histogram - geo_histogram()
# An area chart - geom_area()


# Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# These two graphs look the same. The first one is more efficient because it enters the "data" and # "mapping" arguments into the global "ggplot()" function,
# whereas the second enters them into the "geom_point()" and "geom_smooth()"
>>>>>>> 333a6c412c7a689d232b5af0e23de7fa80cf517c
# layers separately. 