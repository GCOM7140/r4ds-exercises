---
  title: "Chris Hendricks RDS Exercise 2"
output: github_document
---
  
  #Trying to get this RMD stuff to work ^
  
  #Prepare packages
  library(tidyverse)
?mpg

#Checking out some stuff about the dataset

str(mpg)
head(mpg)

#Cool stuff, moving on to the questions

#**Question 1**: Run `ggplot(data = mpg)`. What do you see?
ggplot(data = mpg)

#There is just a big grey box.


#**Question 2**: Make a scatterplot of `cyl` vs `displ`, then make a boxplot with the same variables. What additional information does the boxplot convey? 

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

#Boxplot shows us median values of the data as well as standard deviations via box outline.

##**Question 3**: What happens if you make a scatterplot of `class` vs `drv`? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

#It's just really hard to understand what this first chart is telling us. Once you do get it, it still only shows us that each class "places" in a category, but doesnt tell us things like distribution, sales volume, or any type of numerical data we could work with.

#Alternative
ggplot(mpg, aes(x = class, y = drv)) + geom_bin2d()

#I think bin2d is a good way to graph this data, after experimenting with a bunch of ggplots. Here we get a count of the number of cases of each class that exist within each category, with a color density responding to quantity of cases. Really quick and easy to understand visual for this data.

##**Question 4**: What geom would you use to draw:
  
  #- A line chart? - geom_line()
  # - A boxplot? - geom_boxplot()
  # - A histogram? - geom_histogram()
  # - An area chart? - geom_area ()
#

##**Question 5**: Will these two graphs look different? Why/why not?
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#Without running them, which i assume is the point of the question, I would say that no these specific charts should not look different (code here results in the same thing). However, any additional charts run with the former code would use the same mapping as the first two, while charts with the latter code would require code to map the variables/aesthetics.

#So let's see about after I run them...

#It looks like I was correct! ~Whew.

#End of Exercises 2
