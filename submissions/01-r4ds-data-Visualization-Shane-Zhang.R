---
title: "UVA GCOM7140: Homework Exercise 2"
author: "Shane Zhang"
date: "April 3, 2018"
output: R script
---

#Q1

library(tidyverse)
?mpg

ggplot(data = mpg)
----------------------------------------------------
  
#Q2

ggplot(data = mpg, aes(x = cyl, y = displ)) + geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + geom_boxplot()
----------------------------------------------------
  
#Q3

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
-----------------------------------------------------

#Q4

ggplot(data = mpg, aes(x = class, y = cyl)) + geom_line()
-----------------------------------------------------------
  
  
#Q5

  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
-----------------------------------------------------------

