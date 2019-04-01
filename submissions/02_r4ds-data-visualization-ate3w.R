# Data Visualization

# Question 1
ggplot(data = mpg)

# An empty graph

# Question 2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# Shows the same data but boxplots offers a lot more information

# Question 3
ggplot(data = mpg, aes(x = class, y = drv)) +
  geom_point()
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# The first graph gives no actual context

# Question 4
# geom_line()
# geom_boxplot()
# geom_histogram()
# geom_area() or geom_bar()

# Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# These graphs are the same