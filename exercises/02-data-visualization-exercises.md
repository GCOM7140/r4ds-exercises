Data Visualization Exercises
================

The following five questions are based on concepts covered in [Chapter 3 of R4DS](http://r4ds.had.co.nz/data-visualisation.html) and can be answered using the `mpg` dataset from the `ggplot2` package. Start by loading the `tidyverse` package, which includes `ggplot2`.

``` r
library(tidyverse)
```

Run `?mpg` in the console to familiarize yourself with the dataset.

------------------------------------------------------------------------

**Question 1**: Run `ggplot(data = mpg)`. What do you see?

This question is [3.2.4\#1](http://r4ds.had.co.nz/data-visualisation.html#exercises). It is designed to get you thinking about visualizations with [`ggplot()`](http://r4ds.had.co.nz/data-visualisation.html#creating-a-ggplot) from the ground (i.e., canvas) up.

------------------------------------------------------------------------

**Question 2**: Make a scatterplot of `cyl` vs `displ`, then make a boxplot with the same variables. What additional information does the boxplot convey?

**Hint:** Use `as.factor(cyl)` while specifying the boxplot.

This question is based on [3.2.4\#4](http://r4ds.had.co.nz/data-visualisation.html#exercises). It is designed to strengthen your ability to plot a continuous variable by a categorical variable.

------------------------------------------------------------------------

**Question 3**: What happens if you make a scatterplot of `class` vs `drv`? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

**Hint:** Use `geom_bar()` with `position = "fill"`. `geom_bar()` is covered in [Section 3.8](http://r4ds.had.co.nz/data-visualisation.html#position-adjustments).

This question is based on [3.2.4\#5](http://r4ds.had.co.nz/data-visualisation.html#exercises). It is designed to strengthen your ability to plot the joint distribution of two categorical variables.

------------------------------------------------------------------------

**Question 4**: What geom would you use to draw:

-   A line chart?
-   A boxplot?
-   A histogram?
-   An area chart?

This question is [3.6.1\#1](http://r4ds.had.co.nz/data-visualisation.html#exercises-3). It is designed to strengthen your knowledege of the various [`ggplot()` geom objects](http://r4ds.had.co.nz/data-visualisation.html#geometric-objects).

------------------------------------------------------------------------

**Question 5**: Will these two graphs look different? Why/why not?

``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
```

This question is [3.6.1\#5](http://r4ds.had.co.nz/data-visualisation.html#exercises-3). It is designed to strengthen your understanding of inheritence with respect to the [`ggplot()`](http://r4ds.had.co.nz/data-visualisation.html#creating-a-ggplot) `mapping` argument.
