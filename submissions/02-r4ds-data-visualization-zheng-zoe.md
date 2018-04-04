Answers to the R4DS Data Visulization Exercise
================
Zoe Zheng
April 3, 2018


``` r
library(tidyverse)
```

    ## ── Attaching packages ────────────────────────────────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.7.2     ✔ stringr 1.3.0
    ## ✔ readr   1.1.1     ✔ forcats 0.2.0

    ## ── Conflicts ───────────────────────────────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(ggplot2)
```

**Question 1**: Run `ggplot(data = mpg)`. What do you see?

``` r
ggplot(data = mpg)
```

![](02_files/figure-markdown_github/unnamed-chunk-2-1.png)

There is nothing showed in the plots section. **Question 2**: Make a scatterplot of `cyl` by `displ`, then make a boxplot to visualize the data. What additional information does the boxplot convey? scatterplot of `cyl` by `displ`

``` r
ggplot(mpg, aes(cyl,displ)) + geom_point()
```

![](02_files/figure-markdown_github/unnamed-chunk-3-1.png)

The scatterplot shows as the number of cylinders increases, the engine displacement increases.

boxplot of `cyl` by `displ`

``` r
ggplot(mpg, aes(as.factor(cyl),displ)) + geom_boxplot()
```

![](02_files/figure-markdown_github/unnamed-chunk-4-1.png)

The boxplot shows the similar information as scatterplot does. In addition, we can also see the distribution of data, such as minimum, maximum as well as median within each category.

**Question 3**: What happens if you make a scatterplot of `class` vs `drv`? Create an alternative visualization that better conveys the information.

``` r
ggplot(mpg, aes(class,drv)) + geom_point()
```

![](02_files/figure-markdown_github/unnamed-chunk-5-1.png)

``` r
ggplot(mpg) + geom_bar(mapping=aes(x=class,fill=drv),position = "fill")
```

![](02_files/figure-markdown_github/unnamed-chunk-5-2.png)

In the scatterplot, the relationship between type of car and whether the car is front-wheel/rear-wheel/four-wheel drive is not clear. Instead, it's better to use a bar char to show the percentage of drive type within each car class.

**Question 4**:What geom would you use to draw: - A line chart?

``` r
'+geom_line()'
```

    ## [1] "+geom_line()"

-   A boxplot?

``` r
'+geom_boxplot()'
```

    ## [1] "+geom_boxplot()"

-   A histogram?

``` r
'+geom_histogram()'
```

    ## [1] "+geom_histogram()"

-   An area chart?

``` r
'+geom_area()'
```

    ## [1] "+geom_area()"

**Question 5**: Will the graphs created by the two code blocks below look different? Why/why not?

``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
 geom_point() +
 geom_smooth()
```

    ## `geom_smooth()` using method = 'loess'

![](02_files/figure-markdown_github/unnamed-chunk-10-1.png)

``` r
ggplot() +
 geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) +
 geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
```

    ## `geom_smooth()` using method = 'loess'

![](02_files/figure-markdown_github/unnamed-chunk-10-2.png)

These two code blocks will generate same graphs. The first code block claims the aes() in ggplot(), so that both geom\_point() and geom\_smooth() follows this aes; the second code block states aes() separately in both geom\_point() and geom\_smooth(), but these two methods have the same effect.
