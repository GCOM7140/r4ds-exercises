#' ---
#' title: "Answers to the R4DS Data Visualization Exercise"
#' author: Noah Rodammer
#' date: April 2, 2018
#' output: github_document
#' ---


library(tidyverse)
?mpg

#' **Question 1**: Run ggplot(data = mpg). What do you see?  

ggplot(data=mpg)

#' If you don't add anything else, all you see is a gray screen. It doesn't 
#' have any plots which would be there.


#' **Question 2**: Make a scatterplot of cyl by displ, then make a boxplot to 
#' visualize the data. What additional information does the boxplot convey? 


mpg %>%
  ggplot() +
geom_point(mapping = aes(x = cyl , y = displ)) 

mpg %>%
  ggplot() +
  geom_boxplot(mapping = aes(x=as.factor(cyl),displ))

#' It adds statistical information like median, outliers, quartiles, etc.

#' **Question 3**: How does
#' What happens if you make a scatterplot of class vs drv? Create an alternative 
#' visualization that better conveys the information. 

mpg %>%
  ggplot() +
  geom_point(mapping = aes(x = class , y = drv))

#' It looks really uninterpretable, because there are overlapping points.

mpg %>%
  ggplot() +
  geom_bar(mapping = aes(x = class, fill=drv),position="fill")


#' **Question 4**:What geom would you use to draw:
#' A line chart?
#' geom_line

#' A boxplot?
#' geom_boxplot

#' A histogram?
#' geom_histogram

#' An area chart?
#' geom_area()



#' **Question 5**:Will the graphs created by the two code blocks below look 
#' different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#' Yes, the code displays the same thing, because the data and mapping carry 
#' through if it is used as an argument for ggplot. 