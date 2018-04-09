Exploratory Data Analysis (EDA) Exercises
================
Richard Potter
4/10/2018

------------------------------------------------------------------------

**Initial Operations**

``` r
library(tidyverse)
```

    ## ── Attaching packages ──────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.8.0     ✔ stringr 1.3.0
    ## ✔ readr   1.1.1     ✔ forcats 0.3.0

    ## ── Conflicts ─────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
?diamonds
```

------------------------------------------------------------------------

**Exercise 1**

**Question**: Explore the distribution of `price` with `geom_histogram()` and other functions. Challenge yourself to go beyond the first plot you generate, which might might look something like this:

`diamonds %>%    ggplot(aes(price)) +    geom_histogram()`

**Answer**: See below for visualizations. In the end, I am not surprised that the data follow a distribution which declines rapidly, almost exponentially from the start. Furthermore, it seems that there are bumps around the 1st quartile and mean prices of 950 and 3933 (here, more in the 4000s, below the large number of $5000. I would attribute this to being a little under 1000 and 4000 dollars. With more nuanced evaluation, it may be clear that it is following price psychology, and that many of the diamonds are priced immediately below large numbers to give the illusion of a larger number.

``` r
summary(diamonds$price)
```

    ##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
    ##     326     950    2401    3933    5324   18823

``` r
diamonds %>% 
  ggplot(aes(price)) +
  geom_histogram(binwidth = 200)
```

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-2-1.png)

``` r
diamonds %>% 
  ggplot(aes(price)) +
  geom_histogram(binwidth = 100)
```

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-2-2.png)

``` r
diamonds %>% 
  ggplot(aes(price)) +
  geom_density()
```

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-2-3.png)

------------------------------------------------------------------------

**Exercise 2**

**Question**: Which of the 4Cs (i.e., `carat`, `cut`, `color`, and `clarity`) is most important for predicting the `price` of a diamond?

**Answer**: Based on the plots, it seems that the largest predictor for the price of a diamond is the number of carats it contains.

``` r
ggplot(diamonds) + 
  geom_point(aes(x = carat,     y = price))
```

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-3-1.png)

``` r
ggplot(diamonds) + 
  geom_boxplot(aes(x = cut,     y = price))
```

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-3-2.png)

``` r
ggplot(diamonds) + 
  geom_boxplot(aes(x = color,   y = price))
```

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-3-3.png)

``` r
ggplot(diamonds) + 
  geom_boxplot(aes(x = clarity, y = price))
```

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-3-4.png)

------------------------------------------------------------------------

**Exercise 3**

**Question**: Visualize the distribution of `carat`, partitioned by `price`. Then, after revisiting faceting, use `facet_wrap()` to accomplish the same.

**Answer**: See below.

``` r
diamonds %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf),
                            dig.lab = 10)) %>% 
  ggplot() +
  geom_boxplot(aes(price_binned, carat))
```

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-4-1.png)

``` r
diamonds %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf),
                            dig.lab = 10)) %>% 
  ggplot() +
  geom_histogram(aes(carat)) +
  facet_wrap(~ price_binned)
```

    ## `stat_bin()` using `bins = 30`. Pick better value with `binwidth`.

![](03-r4ds-exploratory-data-analysis-exercises-potter-richard_files/figure-markdown_github/unnamed-chunk-4-2.png)
