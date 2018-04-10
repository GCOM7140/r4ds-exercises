# r4ds questions #2 
library(tidyverse)



##### Question 1 
ggplot(data = mpg)

# I see nothing, probably becuase ggplot sees the whole data set 

##### Question 2 

mpg %>% 
  ggplot() +
  geom_point(mapping = aes(x = cyl, y = displ))

mpg %>% 
  ggplot() +
  geom_boxplot(mapping = aes(x = as.factor(cyl), y = displ)) 
#the Box plot gives slightly more information in the display 


###### Question 3 

mpg %>% 
  ggplot() +
  geom_point(mapping = aes(x = class, y = drv)) 

mpg %>% 
  ggplot() +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")


####### Question 4 

# geom_line()
# geom_boxplot()
# geom_histogram()
# geom_area() 


######### Question 5 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# It doesnt matter that there is the extra information in geom smooth 
