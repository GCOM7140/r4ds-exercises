Answers to the R4DS Data Transformation Exercise
================
Jeff Boichuk
March 29, 2018

``` r
library(tidyverse)
```

    ## ── Attaching packages ─────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 2.2.1     ✔ purrr   0.2.4
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.4
    ## ✔ tidyr   0.8.0     ✔ stringr 1.3.0
    ## ✔ readr   1.1.1     ✔ forcats 0.3.0

    ## ── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(nycflights13)
```

**Question 1**: The following questions ask you to find flights that meet certain criteria and then count them.
- How many flights flew into LAX?

``` r
flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()
```

    ## [1] 16174

-   How many flights flew out of LAX?

``` r
flights %>% 
  filter(origin == 'LAX') %>% 
  nrow()
```

    ## [1] 0

-   How many flights are greater than or equal to 2000 miles?

``` r
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()
```

    ## [1] 51695

-   How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

``` r
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()
```

    ## [1] 5737

**Question 2**: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing `arr_time`).

``` r
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()
```

    ## [1] 458

**Question 3**: How does [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) treat missing values? How could you sort all rows with a missing `arr_time` to the top of the dataset?

With the arrange function, all non-missing values get sorted in ascending or descending fashion; then rows with missing values get displayed. The following code brings missing values to the top, then sorts the observations in descending order:

``` r
flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))
```

    ## # A tibble: 336,776 x 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ##  1  2013     1     1     2016           1930       46.       NA
    ##  2  2013     1     1       NA           1630       NA        NA
    ##  3  2013     1     1       NA           1935       NA        NA
    ##  4  2013     1     1       NA           1500       NA        NA
    ##  5  2013     1     1       NA            600       NA        NA
    ##  6  2013     1     2     2041           2045       -4.       NA
    ##  7  2013     1     2     2145           2129       16.       NA
    ##  8  2013     1     2       NA           1540       NA        NA
    ##  9  2013     1     2       NA           1620       NA        NA
    ## 10  2013     1     2       NA           1355       NA        NA
    ## # ... with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
    ## #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
    ## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>

**Question 4**: What do you observe after running the code below? How does this behavior reflect how [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select) helpers deal with uppercase and lowercase matching by default? How can you change that default?

``` r
select(flights, contains("TIME"))
```

    ## # A tibble: 336,776 x 6
    ##    dep_time sched_dep_time arr_time sched_arr_time air_time
    ##       <int>          <int>    <int>          <int>    <dbl>
    ##  1      517            515      830            819     227.
    ##  2      533            529      850            830     227.
    ##  3      542            540      923            850     160.
    ##  4      544            545     1004           1022     183.
    ##  5      554            600      812            837     116.
    ##  6      554            558      740            728     150.
    ##  7      555            600      913            854     158.
    ##  8      557            600      709            723      53.
    ##  9      557            600      838            846     140.
    ## 10      558            600      753            745     138.
    ## # ... with 336,766 more rows, and 1 more variable: time_hour <dttm>

The referenced code selects six columns in the `flights` dataset, because the `contains()` function is not case-sensitive by default. You can set the `ignore.case` argument to `FALSE` to change this behavior as follows:

``` r
select(flights, contains("TIME", ignore.case = FALSE))
```

    ## # A tibble: 336,776 x 0

**Question 5**: For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list?

``` r
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)
```

    ## # A tibble: 3 x 3
    ##   dest  dep_delay_mins dep_delay_pct_of_total
    ##   <chr>          <dbl>                  <dbl>
    ## 1 SFO          197238.                  0.296
    ## 2 LAX          185631.                  0.278
    ## 3 LAS           70351.                  0.105
