Data Visualization Exercises
================

The following questions are based on concepts covered in [Chapter 3](http://r4ds.had.co.nz/data-visualisation.html) of R4DS, and answers to them lie in the `mpg` dataset of the ggplot2 package. Load the tidyverse, which includes ggplot2, to start working on them.

``` r
library(tidyverse)
```

------------------------------------------------------------------------

**Question 1**: Run `ggplot(data = mpg)`. What do you see?

We developed this question based on the first exercise in section [3.2.4](http://r4ds.had.co.nz/data-visualisation.html#exercises) of R4DS. It is designed to get you thinking about visualizations with [`ggplot()`](http://r4ds.had.co.nz/data-visualisation.html#creating-a-ggplot) from the ground (i.e., canvas) up.

install.packages("tidyverse")
install.packages("nycflights13")
library(tidyverse)
library(nycflights13)
ggplot(data = mpg)
------------------------------------------------------------------------

**Question 2**: Make a scatterplot of `cyl` vs `displ`. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

**Hint:** Use `as.factor(cyl)` while specifying the boxplot.

We developed this question based on the fourth exercise in section [3.2.4](http://r4ds.had.co.nz/data-visualisation.html#exercises) of R4DS. It is designed to strengthen your ability to plot a continuous variable by a categorical variable.

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
------------------------------------------------------------------------

**Question 3**: What happens if you make a scatterplot of `class` vs `drv`? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

**Hint:** Use `geom_bar()` with `position = "fill"`. `geom_bar()` is covered in [Section 3.8](http://r4ds.had.co.nz/data-visualisation.html#position-adjustments).

We developed this question based on the fifth exercise in section [3.2.4](http://r4ds.had.co.nz/data-visualisation.html#exercises) of R4DS. It is designed to strengthen your ability to plot the joint distribution of two categorical variables.

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")
------------------------------------------------------------------------

**Question 4**: What geom would you use to draw:

-   A line chart?
-   A boxplot?
-   A histogram?
-   An area chart?
geom_line()
geom_boxplot()
geom_histogram()
geom_area() 

This question is the first exercise in section [3.6.1](http://r4ds.had.co.nz/data-visualisation.html#exercises-3) of R4DS. It is designed to strengthen your knowledege of the various [`ggplot()` geom objects](http://r4ds.had.co.nz/data-visualisation.html#geometric-objects).

------------------------------------------------------------------------

**Question 5**: Will these two graphs look different? Why/why not?
k
``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
```

This question is the fifth exercise in section [3.6.1](http://r4ds.had.co.nz/data-visualisation.html#exercises-3) of R4DS. It is designed to strengthen your understanding of inheritence with respect to the [`ggplot()`](http://r4ds.had.co.nz/data-visualisation.html#creating-a-ggplot) `mapping` argument.
