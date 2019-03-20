# Data Visualization Exercises

# Question 1
ggplot(data = mpg)

# Question 2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

# Question 3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# Question 4
# - geom_line()
# - geom_boxplot()
# - geom_histogram()
# - geom_area() or geom_bar()

# Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#They are the same but the first one is much easier to produce