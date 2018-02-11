Data Transformation Solutions
================

``` r
# required packages
library(tidyverse)
library(nycflights13)
```

------------------------------------------------------------------------

**Question 1**: The following questions ask you to find the number of flights that meet certain criteria. Hint: Count the number of rows using `nrow()` after you have filtered the dataset. A review of different comparison operators is presented in [5.2.2](http://r4ds.had.co.nz/transform.html#logical-operators).
*This question is based on [5.2.4.\#1](http://r4ds.had.co.nz/transform.html#exercises-7) and grows your ability to use [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter).*

-   How many flights flew into `ORD`
-   How many flights flew out of `ORD`
-   How many flights are less than 100 miles?
-   How many flights were destined for Houston airports ('IAH' or 'HOU'), but did not originate out of 'JFK'? Hint: Use the `%in%` operator. Also, use the exclamation mark (`!`), which means NOT.

**Answer:**

-   17,283 flights - `flights %>% filter(dest == 'ORD') %>% nrow()`

-   0 flights - `flights %>% filter(origin == 'ORD') %>% nrow()`

Note: This is a trick question. You can confirm the correct answer is zero by running `?flights`. The dataset description states: "On-time data for all flights that departed NYC (i.e. JFK, LGA or EWR)". 'ORD' is the airport code for Chicago O'Hare, so zero flights in this dataset originated from O'Hare.

-   1,633 flights - `flights %>% filter(distance < 100) %>% nrow()`

-   8,325 flights - `flights %>% filter(dest %in% c('IAH', 'HOU'), origin != 'JFK') %>% nrow()`

------------------------------------------------------------------------

**Question 2**: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but has missing `arr_time` (never arrived?!).
*This question is based on [5.2.4.\#3](http://r4ds.had.co.nz/transform.html#exercises-7) and grows your knowledge of how [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) treats `NA` values.*

**Answer:**
458 flights

``` r
flights %>% 
  filter(is.na(arr_time), !is.na(dep_time)) %>% 
  nrow()
```

    ## [1] 458

------------------------------------------------------------------------

**Question 3**: How are missing values treated by `arrange()`? How could you sort all rows with a missing `arr_time` to the top of the dataset?
*This question is based on [5.3.1.\#1](http://r4ds.had.co.nz/transform.html#exercises-8) and test how [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) treats `NA` values.*

**Answer**: With the `arrange()` function all non-missing values are sorted in ascending or descending fashion, and then the rows with missing values are displayed last.

Here is the code to sort observations in descending order with the missing values at the top:

``` r
flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))
```

    ## # A tibble: 336,776 x 19
    ##     year month   day dep_time sched_dep_time dep_delay arr_time
    ##    <int> <int> <int>    <int>          <int>     <dbl>    <int>
    ##  1  2013     1     1     2016           1930     46.0        NA
    ##  2  2013     1     1       NA           1630     NA          NA
    ##  3  2013     1     1       NA           1935     NA          NA
    ##  4  2013     1     1       NA           1500     NA          NA
    ##  5  2013     1     1       NA            600     NA          NA
    ##  6  2013     1     2     2041           2045    - 4.00       NA
    ##  7  2013     1     2     2145           2129     16.0        NA
    ##  8  2013     1     2       NA           1540     NA          NA
    ##  9  2013     1     2       NA           1620     NA          NA
    ## 10  2013     1     2       NA           1355     NA          NA
    ## # ... with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
    ## #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
    ## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>

Note: `is.na(arr_time)` converts `arr_time` into `TRUE/FALSE` values. When sorting `TRUE/FALSE` values in ascending order the `FALSE`s are listed first, so we must sort those in descending order to make the missing rows where `is.na(arr_time)` is `TRUE` rise to the top of the dataset.

------------------------------------------------------------------------

**Question 4**: What do you observe after running the code below? How does this behavior reflect how select helpers deal with upper and lowercase matching by default? How can you change that default?

``` r
select(flights, contains("TIME"))`
```

*This question is based on [5.4.1.\#4](http://r4ds.had.co.nz/transform.html#exercises-9) and grows your ability to use [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select).*

**Answer**: The current code fails to select any column names because the `contains()` function is case-sensitive by default. You can set the `ignore.case` argument to `TRUE` to find any match of "TIME" regardless of the case, like this:

``` r
select(flights, contains("TIME", ignore.case = TRUE))
```

------------------------------------------------------------------------

**Question 5**: For each destination, compute the total minutes of delay and then determine what proportion of total delay minutes each destination represents. What are the top 3 destinations by proportion of total and what proportions do each of the top 3 destinations represent? Hint: Use `summarize()` and `arrange()` to quickly find the top 3. The `summarize()` command is reviewed in [5.6](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) and `arrange()` is reviewed in [5.3](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange).
*This question is based on [5.7.1.\#4](http://r4ds.had.co.nz/transform.html#exercises-12) and grows your ability to calculate a per group percentage of total [(link)](http://r4ds.had.co.nz/transform.html#grouped-mutates-and-filters).*

**Answer**:

1.  ORD = 5.4%
2.  ATL = 5.0%
3.  SFO = 3.9%

``` r
flights %>%
  filter(dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(delay_mins = sum(dep_delay)) %>%
  mutate(delay_pct_of_total = delay_mins / sum(delay_mins)) %>%
  arrange(-delay_pct_of_total)
```

    ## # A tibble: 103 x 3
    ##    dest  delay_mins delay_pct_of_total
    ##    <chr>      <dbl>              <dbl>
    ##  1 ORD       275023             0.0544
    ##  2 ATL       254414             0.0503
    ##  3 SFO       197238             0.0390
    ##  4 MCO       195015             0.0386
    ##  5 BOS       185833             0.0367
    ##  6 LAX       185631             0.0367
    ##  7 FLL       182464             0.0361
    ##  8 CLT       171878             0.0340
    ##  9 DTW       136887             0.0271
    ## 10 MIA       135136             0.0267
    ## # ... with 93 more rows
