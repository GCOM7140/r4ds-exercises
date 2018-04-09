#' ---
#' title: "R4DS Exercise #2"
#' author: Dominic Sfreddo
#' date: March 30, 2018
#' output: github_document
#' ---

knitr::opts_chunk$set(echo = TRUE)

library(tidyverse)
install.packages("knitr")
library(knitr)
?mpg


#1

ggplot(data = mpg)
 #It is an empty plot since only the data is being specified.


#2

ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = cyl, y = displ)
  )

ggplot(data = mpg) +
  geom_boxplot(
    aes(x = as.factor(cyl), y = displ)
  )
  

#3

ggplot(data = mpg) +
  geom_point(
    aes(x = class, y = drv)
  )

#This produces categories of classes and drives, but doesn't show if points overlap.

ggplot(data = mpg) +
  geom_bar(
    aes(x = class, fill = drv, position = "fill")
  )


#4

#A line chart? - geom_smooth
#A boxplot? - geom_boxplot
#A histogram? - geom_histogram
#An area chart? - geom_area


#5

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#These graphs will not look different since they each specify the same data set and mapping argument. It does not matter that the mapping argument is set up in different funtions.