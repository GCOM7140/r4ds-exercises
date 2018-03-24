Exploratory Data Analysis (EDA) Solutions
================

``` r
# required package
library(tidyverse)
```

------------------------------------------------------------------------

**Question 1**: Plot the distribution of price. Describe the distribution. Hint: You can also use `summary(diamonds$price)` to view a quantitative assessment of the distribution.
*This question is [7.3.4.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-13) and grows your ability to plot a histogram to view a distribution [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#visualising-distributions).*

**Answer**: The distribution has a very long tail to the most expensive diamonds. However, the majority of diamonds are $1,000 with a small bump below $5,000.

``` r
ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x=price), binwidth = 30)
```

![](03-exploratory-data-analysis-solutions_files/figure-markdown_github/Q1-1.png)

------------------------------------------------------------------------

**Question 2**: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?
*This question is based on [7.5.1.1.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-15) and grows your ability to interpret variable relationships from plots [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation).*

**Answer**: Carat. There are a number of ways to visualize the data; however, the correlation appears to be most dramatic between price and carat.

``` r
# Scatterplot of carat and price (plotting price on y-axis aids interpretation)
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()
```

![](03-exploratory-data-analysis-solutions_files/figure-markdown_github/Q2-1.png)

``` r
# This can be repeated for categorical vars clarity and color
ggplot(diamonds, aes(x=cut, y=price)) + 
  geom_boxplot()
```

![](03-exploratory-data-analysis-solutions_files/figure-markdown_github/Q2-2.png)

``` r
# To look at the carat variable as a box plot as well, first "bin" the carat 
# cariable by using the `cut` function, then plot. The code below creates a new 
# variable called `carat_binned` that puts each observation into a "bin" that 
# has a width of .5 (e.g. 0.0-0.5, 0.5-1.0, 1.0-1.5, etc.).
diamonds %>%
  mutate(carat_binned = cut(carat, breaks=c(seq(0, max(carat), .5), max(carat)))) %>%
  ggplot(., aes(x=carat_binned, y=price)) + 
    geom_boxplot()
```

![](03-exploratory-data-analysis-solutions_files/figure-markdown_github/Q2-3.png)

------------------------------------------------------------------------

**Question 3**: Visualize the distribution of carat, partitioned by price. Hint: Bin the price and show the carat distribution for each bin. You can bin the data with this command:

`mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10))`

In this question you are also encouraged to try and use faceting. Review Section [3.5](http://r4ds.had.co.nz/data-visualisation.html#facets) for details on facetting. *This question is based on [7.5.3.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-17) and grows your ability to interpret variable relationships from plots [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation).*

**Answer**:

``` r
diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()
```

![](03-exploratory-data-analysis-solutions_files/figure-markdown_github/Q3-1.png)

``` r
# Another acceptable answer that employs faceting
diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, 
                            breaks=c(seq(0, max(price), 5000), Inf), 
                            dig.lab=10)) %>%
  ggplot(., aes(x=carat, fill=price_binned)) + 
  geom_histogram(bins=50, show.legend = FALSE) + 
  facet_wrap(~ price_binned, scales = 'free_y', ncol = 1)
```

![](03-exploratory-data-analysis-solutions_files/figure-markdown_github/Q3-2.png)