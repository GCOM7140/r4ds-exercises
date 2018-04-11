Exploratory Data Analysis (EDA) Exercises
================
Zoe Zheng
April 10, 2018

The following 3 questions are based on concepts covered in Chapters 7-8 in R4DS and can be answered using the `diamonds` dataset from the `ggplot2` package. Start by loading the `tidyverse` package, which includes `ggplot2`.

``` r
library(tidyverse)
```

It is highly recommended to run `?diamonds` from the R console to first familiarize yourself with the dataset.

**Question 1**: Plot the distribution of price. Describe the distribution. Hint: You can also use `summary(diamonds$price)` to view a quantitative assessment of the distribution.
*This question is [7.3.4.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-13) and grows your ability to plot a histogram to view a distribution [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#visualising-distributions).* ---

``` r
summary(diamonds$price)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     326     950    2401    3933    5324   18823

``` r
getmode <- function(v) {
   uniqv <- unique(v)
   uniqv[which.max(tabulate(match(v, uniqv)))]
}
getmode(diamonds$price)
```

    ## [1] 605

``` r
ggplot(diamonds,aes(price)) + geom_density()
```

![](03-exploratory-data-analysis-exercises-zheng-zoe_files/figure-markdown_github/question%201-1.png)

The price ranges from 300 to 19000, and most of the prices concentrate around 600. There are a small amount of price around 5000.

**Question 2**: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?
*This question is based on [7.5.1.1.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-15) and grows your ability to interpret variable relationships from plots [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation).* ---

``` r
ggplot(diamonds,aes(carat,price)) + geom_point()
```

![](03-exploratory-data-analysis-exercises-zheng-zoe_files/figure-markdown_github/question%202-1.png)

``` r
ggplot(diamonds,aes(cut,price)) + geom_point()
```

![](03-exploratory-data-analysis-exercises-zheng-zoe_files/figure-markdown_github/question%202-2.png)

``` r
ggplot(diamonds,aes(clarity,price)) + geom_point()
```

![](03-exploratory-data-analysis-exercises-zheng-zoe_files/figure-markdown_github/question%202-3.png)

``` r
ggplot(diamonds,aes(color,price)) + geom_point()
```

![](03-exploratory-data-analysis-exercises-zheng-zoe_files/figure-markdown_github/question%202-4.png)

Carat is most important. Based on the scatterplot, there is a positive correlation between carat and price.

**Question 3**: Visualize the distribution of carat, partitioned by price. Hint: Bin the price and show the carat distribution for each bin. You can bin the data with this command:

`mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10))`

In this question you are also encouraged to try and use faceting. Review Section [3.5](http://r4ds.had.co.nz/data-visualisation.html#facets) for details on facetting. *This question is based on [7.5.3.\#2](http://r4ds.had.co.nz/exploratory-data-analysis.html#exercises-17) and grows your ability to interpret variable relationships from plots [(link)](http://r4ds.had.co.nz/exploratory-data-analysis.html#covariation).* ---

``` r
diamonds<- diamonds %>% 
mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10))
ggplot(diamonds,aes(price_binned,carat)) + geom_boxplot()
```

![](03-exploratory-data-analysis-exercises-zheng-zoe_files/figure-markdown_github/question%203-1.png)