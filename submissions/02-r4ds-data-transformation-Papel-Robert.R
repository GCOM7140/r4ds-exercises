#' ---
#' title: "Answers to the R4DS 02 Data Transformation Exercise"
#' author: Robert Papel
#' date: April 3, 2018
#' output: github_document
#' ---

library(tidyverse)

mpg
#' **Question 1**: Run ggplot(data = mpg). What do you see?
 
ggplot(data = mpg)

#' **Answer**: A blank, all grey, empty picture comes up. That's probably
#' because all ggplot sees is the data set, and nothing in particular about 
#' that data set
 

#' **Question 2**: Make a scatterplot of cyl vs displ, then make a boxplot with
#' the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, aes(x = cyl, y = displ)) +
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) +
  geom_boxplot()

#' **Answer**: The scatterplot shows groupings, and how more cylinders means
#' more engine displacement. The boxplot groups all the points, and seems (I
#' think?) to show the average, while also showing some outliers (as in where
#' cyl = 8).

#' **Question 3**: What happens if you make a scatterplot of class vs drv? Why
#' is the plot not useful? Create an alternative visualization that displays 
#' the data more effectively.

ggplot(data = mpg, aes(x = class, y = drv)) +
  geom_point()

#' This plot just puts points at the intersections of class and drive-type. It
#' is not useful because it does not show any relationship, etc.

ggplot(data = mpg) +
  geom_bar(position = "fill", aes(x = class, fill = drv))


#' **Question 4**: What geom would you use to draw:

#' A line chart? ----> geom_line()
#' A boxplot? ----> geom_boxplot()
#' A histogram? ----> geom_histogram()
#' An area chart? ----> geom_area()

#' **Question 5**: Question 5: Will these two graphs look different? Why/why
#' not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#' **Answer**: These two plots are the same, because the geom_point and
#' geom_smooth arguments inherit the mapping from ggplot, in the second example #' . The first example just puts the data into the ggplot, whereas the second
#' example is more literal.







