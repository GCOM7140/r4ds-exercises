#' ---
#' title: "Answers to the R4DS Data Visualization Exercises"
#' author: 
#' date: 
#' output: github_document
#' ---

library(tidyverse)

#' __Question 1__: Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

#' An empty graph, appearing as a grey box in the Plots tab of RStudio. Think of
#' this graph as a blank canvas that you can use as a foundation for plots.
#' Running `ggplot()` renders the same blank, grey box.

#' __Question 2__: Make a scatterplot of cyl vs displ. Then, make a boxplot with
#' the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, mapping = aes(x = cyl, y = displ)) +
  geom_point()

ggplot(data = mpg, mapping = aes(x = as.factor(cyl), y = displ)) +
  geom_boxplot()

#' While the scatterplot shows that there is a positive relationship between
#' cylinders and engine displacement, the boxplots display this relationship in
#' greater detail with medians, interquartile ranges, and outlier points. In
#' particular, the medians and non-overlapping interquartile ranges make the
#' relationship quite obvious. The medians roughly show that for every two
#' cylinders, engine displacement increases by 1.5 (i.e., `cyl` == 4 has `disp`
#' = ~2, `cyl` == 6 has `disp` = ~3.5, and `cyl` == 8 has `disp` = ~5).

#' Question 3: What happens if you make a scatterplot of class vs drv? Why is
#' the plot not useful? Create an alternative visualization that displays the
#' data more effectively.

