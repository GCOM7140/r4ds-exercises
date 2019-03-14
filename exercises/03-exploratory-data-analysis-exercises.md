Exploratory Data Analysis (EDA) Exercises
================

The following questions are based on concepts covered in [Chapter 7](https://r4ds.had.co.nz/exploratory-data-analysis.html) of R4DS, and answers to them lie in the `diamonds` dataset of the ggplot2 package. Load the tidyverse, which includes ggplot2, to start working on them.

``` r
library(tidyverse)
```

------------------------------------------------------------------------

**Question 1**: Explore the distribution of `price`. Do you discover anything unusual or surprising? (Hint: Carefully think about the `binwidth` and make sure you try a wide range of values.)

This question is the [second exercise](https://jrnold.github.io/r4ds-exercise-solutions/exploratory-data-analysis.html#exercise-7.3.2) in section [7.3.4](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-13) of R4DS. It is designed to strengthen your ability to [visualize the distribution](http://r4ds.had.co.nz/exploratory-data-analysis.html#visualising-distributions) of a continuous variable with the `geom_histogram()` function.

------------------------------------------------------------------------

**Question 2**: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

We developed this question based on the second exercise in section [7.5.1](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-15) of R4DS. It is designed to strengthen your ability to [interpret variable relationships from plots](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation).

------------------------------------------------------------------------

**Question 3**: Plot the distribution of `carat` across various `price` bins using the `geom_boxplot()` and `geom_histogram()` functions. For the latter, leverage the [`facet_wrap()`](http://r4ds.had.co.nz/data-visualisation.html#facets) function.

How would you describe the relationship between `carat` and `price` based on these visualizations?

We developed this question based on the second exercise in section [7.5.3](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-17) of R4DS. It is designed to strengthen your ability to [interpret variable relationships from plots](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation).
