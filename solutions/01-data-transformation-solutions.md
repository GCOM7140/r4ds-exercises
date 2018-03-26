Data Transformation Solutions
================

The following five questions are based on concepts covered in Chapters 4-6 in R4DS and can be answered using the `flights` dataset from the `nycflights13` package. Start by loading the `tidyverse` and `nycflights13` packages.

``` r
library(tidyverse)
library(nycflights13)
```

Run `?flights` in the console to familiarize yourself with the dataset.

------------------------------------------------------------------------

**Question 1**: The following questions ask you to find flights that meet certain criteria and then count them.

-   How many flights flew into LAX?
-   How many flights flew out of LAX?
-   How many flights are greater than or equal to 2000 miles?
-   How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

**Hint:** For each question, filter the dataset, then count the number of rows using `nrow()`. A review of comparison operators is presented in [5.2.2](http://r4ds.had.co.nz/transform.html#logical-operators). For the fourth question, use the `%in%` operator as well as the exclamation mark (`!`), which means not.

These questions are based on [5.2.4\#1](http://r4ds.had.co.nz/transform.html#exercises-7) and designed to strengthen your ability to use the `dplyr` verb [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter).

**Answers:**

``` r
# How many flights flew into LAX?
flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()
```

    ## [1] 16174

``` r
# How many flights flew out of LAX?
flights %>% 
  filter(origin == 'LAX') %>% 
  nrow()
```

    ## [1] 0

**Note:** This is a trick question. You can confirm the correct answer is zero by running `?flights`. The dataset description states: "On-time data for all flights that departed NYC (i.e. JFK, LGA or EWR)". 'LAX' is the airport code for Los Angeles International Airport, so zero flights in this dataset originated from LAX.

``` r
# How many flights are greater than or equal to 2000 miles?
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()
```

    ## [1] 51695

``` r
# How many flights were destined for airports in the Los Angeles area (LAX, ONT, 
# SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()
```

    ## [1] 5737

------------------------------------------------------------------------

**Question 2**: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing `arr_time`).

This question is based on [5.2.4\#3](http://r4ds.had.co.nz/transform.html#exercises-7) and designed to strengthen your understanding of how the `dplyr` verb [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) treats `NA` values.

**Answer:**

``` r
flights %>% 
  filter(is.na(arr_time), !is.na(dep_time)) %>% 
  nrow()
```

    ## [1] 458

------------------------------------------------------------------------

**Question 3**: How does [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) treat missing values? How could you sort all rows with a missing `arr_time` to the top of the dataset?

This question is based on [5.3.1\#1](http://r4ds.had.co.nz/transform.html#exercises-8) and designed to strengthen your understanding of how the `dplyr` verb [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) treats `NA` values.

**Answer**: With the [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) function, all non-missing values get sorted in ascending or descending fashion; then rows with missing values get displayed.

The following code brings missing values to the top, then sorts the observations in descending order:

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

**Note:** `is.na(arr_time)` converts `arr_time` into `TRUE/FALSE` values. When sorting `TRUE/FALSE` values in ascending order, `FALSE` gets listed first, so `is.na(arr_time)` needed to be sorted in descending order to rise the missing values to the top of the dataset.

------------------------------------------------------------------------

**Question 4**: What do you observe after running the code below? How does this behavior reflect how [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select) helpers deal with uppercase and lowercase matching by default? How can you change that default?

``` r
select(flights, contains("TIME"))`
```

This question is based on [5.4.1\#4](http://r4ds.had.co.nz/transform.html#exercises-9) and designed to strengthen your ability to use the `dplyr` verb [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select).

**Answer**: The current code fails to select any column names because the `contains()` function is case-sensitive by default. You can set the `ignore.case` argument to `TRUE` to find any match of "TIME" regardless of the case, like this:

``` r
select(flights, contains("TIME", ignore.case = TRUE))
```

------------------------------------------------------------------------

**Question 5**: For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list?

**Hint:** Use [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) to find the destinations greater than or equal to 2000 miles away with positive `dep_delay` values, then [`group_by()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) `dest`, then [`summarize()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) to find total departure delay minutes by destination, then [`mutate()`](http://r4ds.had.co.nz/transform.html#add-new-variables-with-mutate) to find proportions, and finally [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) to find the top three.

This question is based on [5.7.1\#4](http://r4ds.had.co.nz/transform.html#exercises-12) and designed to strengthen your ability to calculate [per-group proportions of totals](http://r4ds.had.co.nz/transform.html#grouped-mutates-and-filters).

**Answer**:

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
