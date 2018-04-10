R4DS Data Visualization Exercises
================
Richard Potter
4/2/2018

``` r
library(tidyverse)
library(ggplot2)
```

------------------------------------------------------------------------

**Question 1**: Run `ggplot(data = mpg)`. What do you see?

**Answer**: This results in a tibble, demonstrating the data without any visualizations. The data are sorted alphabetically by manufacturer, then model, then displacement.

``` r
ggplot2::mpg
```

    ## # A tibble: 234 x 11
    ##    manufacturer model    displ  year   cyl trans   drv     cty   hwy fl   
    ##    <chr>        <chr>    <dbl> <int> <int> <chr>   <chr> <int> <int> <chr>
    ##  1 audi         a4        1.80  1999     4 auto(l… f        18    29 p    
    ##  2 audi         a4        1.80  1999     4 manual… f        21    29 p    
    ##  3 audi         a4        2.00  2008     4 manual… f        20    31 p    
    ##  4 audi         a4        2.00  2008     4 auto(a… f        21    30 p    
    ##  5 audi         a4        2.80  1999     6 auto(l… f        16    26 p    
    ##  6 audi         a4        2.80  1999     6 manual… f        18    26 p    
    ##  7 audi         a4        3.10  2008     6 auto(a… f        18    27 p    
    ##  8 audi         a4 quat…  1.80  1999     4 manual… 4        18    26 p    
    ##  9 audi         a4 quat…  1.80  1999     4 auto(l… 4        16    25 p    
    ## 10 audi         a4 quat…  2.00  2008     4 manual… 4        20    28 p    
    ## # ... with 224 more rows, and 1 more variable: class <chr>

------------------------------------------------------------------------

**Question 2**: Make a scatterplot of `cyl` vs `displ`, then make a boxplot with the same variables. What additional information does the boxplot convey?

**Answer**:

``` r
mpg %>% 
  ggplot() +
  geom_point(aes(cyl, displ))
```

![](02-r4ds-data-visualization-exercises-potter-richard_files/figure-markdown_github/Q2-1.png)

``` r
mpg %>% 
  mutate(cyl = as.factor(cyl)) %>% 
  ggplot() +
  geom_boxplot(aes(cyl, displ))
```

![](02-r4ds-data-visualization-exercises-potter-richard_files/figure-markdown_github/Q2-2.png)

------------------------------------------------------------------------

**Question 3**: What happens if you make a scatterplot of `class` vs `drv`? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

**Answer**: This plot is not useful as it plots two categorical variables against each other, and does not show anything other than the presence of vehicles which fit the required intersection. We do not know anything about the information contained in the points, such as frequency.

``` r
mpg %>% 
  ggplot() +
  geom_point(aes(class, drv))
```

![](02-r4ds-data-visualization-exercises-potter-richard_files/figure-markdown_github/Q3-1.png)

``` r
mpg %>% 
  ggplot() +
  geom_bar(aes(class, fill = drv), position = "fill")
```

![](02-r4ds-data-visualization-exercises-potter-richard_files/figure-markdown_github/Q3-2.png)

------------------------------------------------------------------------

**Question 4**: What geom would you use to draw:

-   A line chart?
-   A boxplot?
-   A histogram?
-   An area chart?

**Answer**:

-   `geom_line()`
-   `geom_boxplot()`
-   `geom_histogram()`
-   `geom_area()`

------------------------------------------------------------------------

**Question 5**: Will these two graphs look different? Why/why not?

``` r
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
```

    ## `geom_smooth()` using method = 'loess'

![](02-r4ds-data-visualization-exercises-potter-richard_files/figure-markdown_github/Q5-1.png)

``` r
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
```

    ## `geom_smooth()` using method = 'loess'

![](02-r4ds-data-visualization-exercises-potter-richard_files/figure-markdown_github/Q5-2.png)

**Answer**: These two graphs will have the same result. In the first, the variables are considered as part of the master options, as they are part of the ggplot option, and are then inherited by the geometry. Only because the exact same options are later placed under the geometries, and they are the exact same, then we can have them be the same plot.
