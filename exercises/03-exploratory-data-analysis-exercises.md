Exploratory Data Analysis (EDA) Exercises
================

The following 3 questions are based on concepts covered in Chapters 7-8 in R4DS and can be answered using the `diamonds` dataset from the `ggplot2` package. Start by loading the `tidyverse` package, which includes `ggplot2`.

``` r
library(tidyverse)
```

It is highly recommended to run `?diamonds` from the R console to first familiarize yourself with the dataset.

------------------------------------------------------------------------

**Question 1**: Plot the distribution of price. Describe the distribution. Hint: You can also use `summary(diamonds$price)` to get some hard numbers around the distribution.
*This question is [7.3.4.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-13) and grows your ability to plot a histogram to view a distribution [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#visualising-distributions).*

------------------------------------------------------------------------

**Question 2**: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?
*This question is based on [7.5.1.1.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-15) and grows your ability to interpret variable relationships from plots [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation).*

------------------------------------------------------------------------

**Question 3**: Visualize the distribution of carat, partitioned by price. Hint: Bin the price and show the carat distribution for each bin. You can bin the data with this command:

`mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10))`

In this question you are also encouraged to try and use faceting. Review Section [3.5](http://r4ds.had.co.nz/data-visualisation.html#facets) for details on facetting. *This question is based on [7.5.3.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-17) and grows your ability to interpret variable relationships from plots [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation).*