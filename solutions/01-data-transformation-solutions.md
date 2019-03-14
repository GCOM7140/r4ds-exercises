Data Transformation Solutions
================

The following questions are based on concepts covered in [Chapter 5](https://r4ds.had.co.nz/transform.html) of R4DS, and answers to them lie in the `flights` dataset of the nycflights13 package. Load the tidyverse and nycflights13 packages to start working on them.

``` r
library(tidyverse)
library(nycflights13)
```

------------------------------------------------------------------------

**Question 1**: Responding to this set of questions requires two steps: (a) finding flights that meet certain criteria and (b) counting these subsets of flights.

-   How many flights flew into LAX?
-   How many flights flew out of LAX?
-   How many flights were longer than or equal to 2,000 miles in distance?
-   How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

For each question, consider filtering the `flights` dataset, then counting the number of rows that remain using `nrow()`. You might find it helpful to revisit section [5.2.1](https://r4ds.had.co.nz/transform.html#comparisons) of R4DS, which is where Hadley and Garrett review comparison operators. For the fourth question, consider using the `%in%` operator as well as the exclamation mark (`!`), which you can read in your head or vocalize as "not."

We developed this set of questions based on the first exercise in section [5.2.4](http://r4ds.had.co.nz/transform.html#exercises-7) of R4DS. Each is designed to strengthen your ability to use the dplyr verb [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) effectively.

``` r
# How many flights flew into LAX?
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()
```

    ## [1] 16174

``` r
# How many flights flew out of LAX?
flights %>% 
  filter(origin == "LAX") %>% 
  nrow()
```

    ## [1] 0

``` r
# This is a bit of a trick question. You can confirm that the correct answer is
# zero by running ?flights. The dataset description states: "On-time data for
# all flights that *departed* NYC (i.e. JFK, LGA or EWR)" (emphasis added). LAX
# is the airport code for Los Angeles International Airport, so zero flights in
# this dataset originated from LAX.

# How many flights were longer than or equal to 2,000 miles in distance?
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

**Question 2**: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for `arr_time`).

We developed this question based on the third exercise in section [5.2.4](http://r4ds.had.co.nz/transform.html#exercises-7) of R4DS. It's designed to strengthen your understanding of how the dplyr verb [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) treats `NA` values.

``` r
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()
```

    ## [1] 458

------------------------------------------------------------------------

**Question 3**: How does [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) treat missing values, and how could you sort all of the rows with a missing `arr_time` to the top of the dataset?

We developed this question based on the first exercise in section [5.3.1](http://r4ds.had.co.nz/transform.html#exercises-8) of R4DS. It's designed to strengthen your understanding of how the dplyr verb [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) treats `NA` values.

``` r
# With the arrange() function, all non-missing values get sorted in ascending or
# descending fashion; then rows with missing values get displayed. The following
# code brings the missing values to the top with desc(is.na(arr_time)):

flights %>% 
  arrange(desc(is.na(arr_time)))
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

``` r
# Note: `is.na(arr_time)` converts `arr_time` into `TRUE/FALSE` values. When
# sorting `TRUE/FALSE` values in ascending order, `FALSE` gets listed first, so
# `is.na(arr_time)` needs to be sorted in descending order to lift the missing
# values to the top of the dataset.
```

------------------------------------------------------------------------

**Question 4**: What do you observe after running the code below? How does this behavior reflect how [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select) helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?

``` r
select(flights, contains("TIME"))`
```

We developed this question based on the fourth exercise in section [5.4.1](http://r4ds.had.co.nz/transform.html#exercises-9) of R4DS. It's designed to strengthen your ability to use the dplyr verb [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select) effectively.

``` r
# The code above fails to select any column names because `contains()` is case
# sensitive by default. The following code sets the `ignore.case` argument to
# `TRUE` to select columns that contain "TIME", "time", "TiMe", and so on:

select(flights, contains("TIME", ignore.case = TRUE))
```

    ## # A tibble: 336,776 x 6
    ##    dep_time sched_dep_time arr_time sched_arr_time air_time
    ##       <int>          <int>    <int>          <int>    <dbl>
    ##  1      517            515      830            819      227
    ##  2      533            529      850            830      227
    ##  3      542            540      923            850      160
    ##  4      544            545     1004           1022      183
    ##  5      554            600      812            837      116
    ##  6      554            558      740            728      150
    ##  7      555            600      913            854      158
    ##  8      557            600      709            723       53
    ##  9      557            600      838            846      140
    ## 10      558            600      753            745      138
    ## # … with 336,766 more rows, and 1 more variable: time_hour <dttm>

------------------------------------------------------------------------

**Question 5**: For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

**Hint:** Consider using [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) to find the flights that flew more than or equal to 2,000 miles in distance and had positive `arr_delay` values. Then, [`group_by()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) `dest`, use [`summarize()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) to calculate the total number of arrival-delay minutes by destination, use [`mutate()`](http://r4ds.had.co.nz/transform.html#add-new-variables-with-mutate) to convert this metric into a proportion, use [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) to lift the top destiations to the top of the list, and use `head()` to select the top three.

We developed this question based on the fourth exercise in section [5.7.1](http://r4ds.had.co.nz/transform.html#exercises-12) of R4DS. It's designed to strengthen your ability to calculate [per-group proportions of totals](http://r4ds.had.co.nz/transform.html#grouped-mutates-and-filters).

``` r
flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)
```

    ## # A tibble: 3 x 3
    ##   dest  arr_delay_mins arr_delay_pct_of_total
    ##   <chr>          <dbl>                  <dbl>
    ## 1 SFO           205406                  0.291
    ## 2 LAX           203226                  0.288
    ## 3 LAS            73947                  0.105
