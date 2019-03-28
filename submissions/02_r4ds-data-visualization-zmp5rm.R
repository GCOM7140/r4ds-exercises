---
title: "Data Visualization Solutions"
output: github_document
---
  
  ```{r setup, include = FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

The following questions are based on concepts covered in [Chapter 3][chapter 3]
of R4DS, and answers to them lie in the `mpg` dataset of the ggplot2 package.
Load the tidyverse, which includes ggplot2, to start working on them.

```{r load-packages, warning = FALSE, message = FALSE}
library(tidyverse)
```

--- 
  
  **Question 1**: Run `ggplot(data = mpg)`. What do you see?  
  
  We developed this question based on the first exercise in section [3.2.4][3.2.4
                                                                            Exercises] of R4DS. It is designed to get you thinking about visualizations with
[`ggplot()`][3.2.2] from the ground (i.e., canvas) up.

```{r include = TRUE, eval = TRUE}
ggplot(data = mpg)
# An empty graph, appearing as a grey box in the Plots tab of RStudio. Think of
# this graph as a blank canvas that you can use as a foundation for plots.
# Running `ggplot()` renders the same blank, grey box.
```

---
  
  **Question 2**: Make a scatterplot of `cyl` vs `displ`. Then, make a boxplot
with the same variables. What additional information does the boxplot convey?
  
  **Hint:** Use `as.factor(cyl)` while specifying the boxplot.

We developed this question based on the fourth exercise in section [3.2.4][3.2.4
                                                                           Exercises] of R4DS. It is designed to strengthen your ability to plot a
continuous variable by a categorical variable.

```{r include = TRUE, eval = TRUE}
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
# While the scatterplot shows that there is a positive relationship between
# cylinders and engine displacement, the boxplots display this relationship in
# greater detail with medians, interquartile ranges, and outlier points. In
# particular, the medians and non-overlapping interquartile ranges make the
# relationship quite obvious. The medians roughly show that for every two
# cylinders, engine displacement increases by 1.5 (i.e., `cyl` == 4 has 
# `disp` = ~2, `cyl` == 6 has `disp` = ~3.5, and `cyl` == 8 has `disp` = ~5).
```

---
  
  **Question 3**: What happens if you make a scatterplot of `class` vs `drv`? Why
is the plot not useful? Create an alternative visualization that displays the
data more effectively.

**Hint:** Use `geom_bar()` with `position = "fill"`. `geom_bar()` is covered in
[Section 3.8][3.8].

We developed this question based on the fifth exercise in section [3.2.4][3.2.4
                                                                          Exercises] of R4DS. It is designed to strengthen your ability to plot the joint
distribution of two categorical variables.

```{r include = TRUE, eval = TRUE}
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
# The scatterplot of `class` vs `drv` plots many observations in the same (x, y)
# coordinate space, so it is difficult to gauge the proportion of observations
# for each combination. The bar chart conveys this information much more
# effectively.
```  

---
  
  **Question 4**: What geom would you use to draw:
  
  - A line chart? 
  - A boxplot?
  - A histogram?
  - An area chart? 
  
  This question is the first exercise in section [3.6.1][3.6.1 Exercises] of R4DS.
It is designed to strengthen your knowledege of the various [`ggplot()` geom
                                                             objects][3.6].

```{r include = TRUE, eval =  FALSE}
# - geom_line()
# - geom_boxplot()
# - geom_histogram()
# - geom_area() or geom_bar()
```

---
  
  **Question 5**: Will these two graphs look different? Why/why not?
  
  ```{r eval = FALSE}
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
```

This question is the fifth exercise in section [3.6.1][3.6.1 Exercises] of R4DS.
It is designed to strengthen your understanding of inheritence with respect to
the [`ggplot()`][3.2.2] `mapping` argument.

```{r include = TRUE, eval = TRUE}
# The graphs will be identical, although the first is more efficient, because it
# enters the `data` and `mapping` arguments into the global `ggplot()` function,
# whereas the second enters them into the `geom_point()` and `geom_smooth()`
# layers separately. Geometric objects inherit the `mapping` argument from the
# `ggplot()` command if it is specified. This example illustrates an important
# point: objects can have different mappings, which allows for a great deal of
# flexibility across layers of visualizations.
```