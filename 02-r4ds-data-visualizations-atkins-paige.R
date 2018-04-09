#1
#install.packages("ggplot2")
library(ggplot2)
ggplot(data = mpg)
#Nothing but a gray box in plots

#2
ggplot(data = mpg, aes(x = cyl, y = displ)) + geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + geom_boxplot()
#The boxplot gives more information like quartile and median points

#3
ggplot(mpg, aes(x = class, y = drv)) + geom_point()
ggplot(mpg) +geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
#Its difficult to see how high each observations is in the first graph, but the second is     color coded and has thicker visualizations.

#4
geom_line()      #line chart
geom_boxplot()   #boxplot
geom_histogram() #histogram
geom_area()      #area chart

#5
#ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + geom_point() + geom_smooth()
#ggplot() + geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
#No these graphs are the exact same