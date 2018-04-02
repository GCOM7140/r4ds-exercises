#' ---
#' title: "R4DS Exercise #2"
#' author: Burhan Khan
#' date: March 30, 2018
#' output: github_document
#' ---

#Top
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
?mpg

#Question 1
ggplot(data = mpg)
#I see nothing because the actual plot layers have not been added


#Question 2

#Scatterplot
ggplot(mpg, aes(cyl, displ, col = cyl)) +
  geom_jitter(width = .1) +
  theme_bw() +
  theme(legend.position="none")

#Boxplot
ggplot(mpg, aes(as.factor(cyl), displ)) + 
  geom_boxplot(fill = "lightblue") +
  theme_bw()



#Question 3

#Scatterplot
ggplot(mpg, aes(class, drv)) +
  geom_point()
#It creats a scatter plot with a point at each intersection. It is not useful because it does not convey any information beyond where they intersect

#Barplot
ggplot(mpg, aes(class, fill = drv)) +
  geom_bar(position = "fill", alpha = .8) +
  theme_bw()


#Question 4
#Line = geom_line, box = geom_boxplot, histogram = geom_histogram, area = geom_area

#Question 5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#These graphs do not look different because one just mapped the aesthetics in the actual plot calls while the other did it at the start.