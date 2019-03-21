Answers to the R4DS Data Transformation Exercises
================

``` r
library(tidyverse)
```

    ## ── Attaching packages ──────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.1.0       ✔ purrr   0.3.1  
    ## ✔ tibble  2.0.1       ✔ dplyr   0.8.0.1
    ## ✔ tidyr   0.8.3       ✔ stringr 1.4.0  
    ## ✔ readr   1.3.1       ✔ forcats 0.4.0

    ## ── Conflicts ─────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(nycflights13)
```

**Question 1**: Responding to this set of questions requires two steps:
(a) finding flights that meet certain criteria and (b) counting these
subsets of flights. How many flights flew into LAX?

``` r
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()
```

    ## [1] 16174

How many flights flew out of LAX?

``` r
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()
```

    ## [1] 16174

How many flights were longer than or equal to 2,000 miles in distance?

``` r
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()
```

    ## [1] 51695

How many flights were destined for airports in the Los Angeles area
(LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of
JFK?

``` r
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()
```

    ## [1] 5737

**Question 2**: How many flights were “ghost flights”? A “ghost flight”
is defined as a flight that departed, but never arrived (i.e., has a
missing value for arr\_time).

``` r
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()
```

    ## [1] 458

**Question 3**: How does arrange() treat missing values, and how could
you sort all of the rows with a missing arr\_time to the top of the
dataset?

``` r
# With the arrange() function, all non-missing values get sorted in ascending or
# descending fashion; then rows with missing values get displayed. The following
# code brings the missing values to the top with desc(is.na(arr_time)):

flights %>% 
  arrange(is.na(arr_time) %>% desc())
```

    ## # A tibble: 336,776 x 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ##  1  2013     1     1     2016           1930        46       NA
    ##  2  2013     1     1       NA           1630        NA       NA
    ##  3  2013     1     1       NA           1935        NA       NA
    ##  4  2013     1     1       NA           1500        NA       NA
    ##  5  2013     1     1       NA            600        NA       NA
    ##  6  2013     1     2     2041           2045        -4       NA
    ##  7  2013     1     2     2145           2129        16       NA
    ##  8  2013     1     2       NA           1540        NA       NA
    ##  9  2013     1     2       NA           1620        NA       NA
    ## 10  2013     1     2       NA           1355        NA       NA
    ## # … with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
    ## #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
    ## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>
