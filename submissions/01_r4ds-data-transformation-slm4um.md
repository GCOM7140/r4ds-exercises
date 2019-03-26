Answers to the R4DS Data Transformation Exercise
================

``` r
library(tidyverse)
```

    ## Warning: package 'tidyverse' was built under R version 3.5.3

    ## -- Attaching packages --------------------------------------------------------------------------------- tidyverse 1.2.1 --

    ## v ggplot2 3.1.0       v purrr   0.3.2  
    ## v tibble  2.1.1       v dplyr   0.8.0.1
    ## v tidyr   0.8.3       v stringr 1.4.0  
    ## v readr   1.3.1       v forcats 0.4.0

    ## Warning: package 'ggplot2' was built under R version 3.5.3

    ## Warning: package 'tibble' was built under R version 3.5.3

    ## Warning: package 'tidyr' was built under R version 3.5.3

    ## Warning: package 'purrr' was built under R version 3.5.3

    ## Warning: package 'dplyr' was built under R version 3.5.3

    ## Warning: package 'stringr' was built under R version 3.5.3

    ## Warning: package 'forcats' was built under R version 3.5.3

    ## -- Conflicts ------------------------------------------------------------------------------------ tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(nycflights13)
```

    ## Warning: package 'nycflights13' was built under R version 3.5.3

Question 1 How many flights flew into LAX?

``` r
flights %>%
    filter(dest == "LAX") %>%
    nrow()
```

    ## [1] 16174

``` r
nrow(filter(flights, dest == "LAX"))
```

    ## [1] 16174

``` r
?flights
```

    ## starting httpd help server ... done

``` r
# How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()
```

    ## [1] 0

``` r
# How many flights were longer than or equal to 2000 miles in distance?

flights %>%
  filter(distance >= 2000) %>%
  nrow()
```

    ## [1] 51695

``` r
# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB") & origin != "JFK") %>%
  nrow()
```

    ## [1] 5737

``` r
# Question 2
# How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).

flights %>%
  filter(is.na(dep_time) == F & is.na(arr_time) == T) %>%
  nrow()
```

    ## [1] 458

``` r
# Question 3
# How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?
# arrange() puts all missing values at the bottom of the sorted dataset

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
    ## # ... with 336,766 more rows, and 12 more variables: sched_arr_time <int>,
    ## #   arr_delay <dbl>, carrier <chr>, flight <int>, tailnum <chr>,
    ## #   origin <chr>, dest <chr>, air_time <dbl>, distance <dbl>, hour <dbl>,
    ## #   minute <dbl>, time_hour <dttm>

``` r
# Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?

select(flights, contains("TIME"))
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
    ## # ... with 336,766 more rows, and 1 more variable: time_hour <dttm>

``` r
# The select statement doesn't return any columns.
# contains() seems to not be case sensitive.
# Can override through setting the default value of ignore.case = FALSE

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
    ## # ... with 336,766 more rows, and 1 more variable: time_hour <dttm>

``` r
# Question 5
# For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

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
