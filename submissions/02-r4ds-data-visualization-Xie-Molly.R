#Question 1

ggplot(data = mpg)


#Question 2
ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = cyl, y = displ))

ggplot(data = mpg) +
  geom_boxplot(
    aes(x = as.factor(cyl), y = displ))

#Question 3
ggplot(data = mpg) +
  geom_point(
    aes(x = class, y = drv)
  )
ggplot(data = mpg) +
  geom_bar(
    aes(x = class, fill = drv, position = "fill")
  )

#Question 4
#A line chart? - geom_smooth
#A boxplot? - geom_boxplot
#A histogram? - geom_histogram
#An area chart? - geom_area

