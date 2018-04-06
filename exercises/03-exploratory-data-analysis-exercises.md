Exploratory Data Analysis (EDA) Exercises
================

The following three questions are based on concepts covered in [Chapter 7 of R4DS](http://r4ds.had.co.nz/exploratory-data-analysis.html). They can be answered using the `diamonds` dataset from the `ggplot2` package. Start by loading the `tidyverse` package, which includes `ggplot2`.

``` r
library(tidyverse)
```

Run `?diamonds` in the console to familiarize yourself with the dataset.

------------------------------------------------------------------------

Question 1
----------

Explore the distribution of `price` with `geom_histogram()` and other functions. Challenge yourself to go beyond the first plot you generate, which might might look something like this:

``` r
diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](03-exploratory-data-analysis-exercises_files/figure-markdown_github/unnamed-chunk-1-1.png)

Use prose to describe the distribution you utlimately discover. What are some of the most surprising features of the distribution to you?

**Hint:** It might help if you first view a quantitative assessment of the distribution with `summary(diamonds$price)`.

This question is based on [7.3.4\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-13). It is designed to strengthen your ability to illuminate the distribution of a continuous variable with `geom_histogram()`.

------------------------------------------------------------------------

Question 2
----------

Which of the 4Cs (i.e., `carat`, `cut`, `color`, and `clarity`) is most important for predicting the `price` of a diamond?

This question is based on [7.5.1.1\#1](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-15). It is designed to strengthen your ability to interpret variable relationships from plots (see [here](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation)).

------------------------------------------------------------------------

Question 3
----------

Visualize the distribution of `carat`, partitioned by `price`. Then, after revisiting [Faceting](http://r4ds.had.co.nz/data-visualisation.html#facets), use `facet_wrap()` to accomplish the same.

**Hint:** After binning `price`, plot the distribution of `carat` for each bin. Binning `price` can be accomplished with the following command:

``` r
diamonds %>% 
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  )
```

This question is based on [7.5.3\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-17). It is designed to further strengthen your ability to interpret variable relationships from plots (see [here](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation) again).
