Data Wrangling Solutions
================

The following six exercises are based on concepts covered in [Chapter 12](http://r4ds.had.co.nz/tidy-data.html) and [Chapter 13](http://r4ds.had.co.nz/relational-data.html) of [R for Data Science](http://r4ds.had.co.nz/). Use the `flights` and `who` datasets that come with the `nycflights13` and `tidyverse` packages to work on them, and start by loading the `tidyverse` and `nycflights13`.

``` r
library(tidyverse)
library(nycflights13)
```

Also, run `?flights` and `?who` in the console to (re)familiarize yourself with these datasets.

------------------------------------------------------------------------

Exercise 1
----------

``` r
people <- tribble(
  ~name,            ~key,     ~value,
  #---------------/---------/--------
  "Ousmane Diaby",    "age",      23,
  "Ousmane Diaby", "height",     196,
  "Ousmane Diaby",    "age",      33,
  "Rich Eldh",        "age",      23,
  "Rich Eldh",     "height",     195
)

people %>% 
  spread(key, value)
```

    ## Error: Duplicate identifiers for rows (1, 3)

Why can't you spread `people`? How could you add a new column to `people` to fix the problem?

**Hint:** You can use `group_by()` and `row_number()` to create a `time` column that uniquely identifies time periods in `people`. This `time` column will fix the problem.

**Note:** This question is based on [12.3.3 \#3](http://r4ds.had.co.nz/tidy-data.html#exercises-22). It is designed to help you hone your understanding of how [`spread()`](http://r4ds.had.co.nz/tidy-data.html#spreading) behaves with non-unique rows.

### Solution to Exercise 1:

Spreading `people` fails because there are two different observations for Ousmane's age. R doesn't know which observation you'd prefer to keep, so it throws an error. You can include a `time` variable to distinguish observations at `time == 1` (i.e., today) from observations at `time == 2` (i.e., 10 years from now) and fix this error as follows:

``` r
people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)
```

    ## # A tibble: 3 x 4
    ## # Groups:   name [2]
    ##   name             id   age height
    ##   <chr>         <int> <dbl>  <dbl>
    ## 1 Ousmane Diaby     1   23.   196.
    ## 2 Ousmane Diaby     2   33.    NA 
    ## 3 Rich Eldh         1   23.   195.

------------------------------------------------------------------------

Exercise 2
----------

``` r
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
```

Do you need to [gather](http://r4ds.had.co.nz/tidy-data.html#gathering) or [spread](http://r4ds.had.co.nz/tidy-data.html#spreading) `preg` to tidy it? What variables are there in `preg`?

**Note:** This question is based on [12.3.3 \#4](http://r4ds.had.co.nz/tidy-data.html#exercises-22).

### Solution to Exercise 2

`preg` needs to be gathered because it has values as variable names. The variables in `preg` are `pregnant`, `gender`, and `count`.

``` r
preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")
```

    ## # A tibble: 4 x 3
    ##   pregnant gender count
    ##   <chr>    <chr>  <dbl>
    ## 1 yes      male     NA 
    ## 2 no       male     20.
    ## 3 yes      female   10.
    ## 4 no       female   12.

------------------------------------------------------------------------

Exercise 3
----------

``` r
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))
```

    ## Warning: Expected 3 pieces. Additional pieces discarded in 1 rows [2].

    ## # A tibble: 3 x 3
    ##   one   two   three
    ##   <chr> <chr> <chr>
    ## 1 a     b     c    
    ## 2 d     e     f    
    ## 3 h     i     j

How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the [`separate()`](http://r4ds.had.co.nz/tidy-data.html#separate) function call. What could they do to remedy the situation?

**Note:** This question is based on [12.4.3 \#1](http://r4ds.had.co.nz/tidy-data.html#exercises-23). It is designed to strengthen your ability to parse a column using [`separate()`](http://r4ds.had.co.nz/tidy-data.html#separate).

### Solution to Exercise 3

The warning message indicates that the second observation has an extra piece (or value), and that this extra piece (i.e., "g") was dropped. Setting the `extra` argument to 'merge' rather than 'warn', its default, remedies this situation.

``` r
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')
```

    ## # A tibble: 3 x 3
    ##   one   two   three
    ##   <chr> <chr> <chr>
    ## 1 a     b     c    
    ## 2 d     e     f,g  
    ## 3 h     i     j

------------------------------------------------------------------------

Exercise 4
----------

Both [`separate()`](http://r4ds.had.co.nz/tidy-data.html#separate) and [`unite()`](http://r4ds.had.co.nz/tidy-data.html#unite) have a `remove` argument. What does it do? When does setting it to `FALSE` make sense?

**Note:** This question is based on [12.4.3 \#2](http://r4ds.had.co.nz/tidy-data.html#exercises-23). It is designed to strengthen your ability to parse columns while making use of arguments such as `remove`.

### Solution to Exercise 4

The `remove` argument determines whether R should remove or keep the original column(s) being parsed. The default is to remove the column(s); however, it might make sense to keep the original column(s) for troubleshooting purposes or another operation.

------------------------------------------------------------------------

Exercise 5
----------

Using the [`who` dataset](http://r4ds.had.co.nz/tidy-data.html#case-study), calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?

**Hint:** Build on this code, which tidies `who`:

``` r
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)
```

    ## # A tibble: 76,046 x 6
    ##    country      year var   sex   age   value
    ##    <chr>       <int> <chr> <chr> <chr> <int>
    ##  1 Afghanistan  1997 sp    m     014       0
    ##  2 Afghanistan  1998 sp    m     014      30
    ##  3 Afghanistan  1999 sp    m     014       8
    ##  4 Afghanistan  2000 sp    m     014      52
    ##  5 Afghanistan  2001 sp    m     014     129
    ##  6 Afghanistan  2002 sp    m     014      90
    ##  7 Afghanistan  2003 sp    m     014     127
    ##  8 Afghanistan  2004 sp    m     014     139
    ##  9 Afghanistan  2005 sp    m     014     151
    ## 10 Afghanistan  2006 sp    m     014     193
    ## # ... with 76,036 more rows

**Note:** This question is based on [12.6.1 \#4](http://r4ds.had.co.nz/tidy-data.html#exercises-25). It is designed to strengthen your ability to create a pipeline full of data wrangling and visualization operations.

### Solution to Exercise 5

The extremely low number of cases in Bangladesh in 2009 might surprise you. It is likely an error in the data. For China, the dramatic increase from 2008 to 2009 is surprising. For India, 2007 is definitely something worth looking into.

``` r
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year) %>%
  summarise(cases = sum(value)) %>%
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  ggplot(aes(x = year, y = cases, colour = country)) + 
  geom_point() + 
  geom_line()
```

![](04-data-wrangling-solutions_files/figure-markdown_github/unnamed-chunk-9-1.png)

------------------------------------------------------------------------

Exercise 6
----------

Begin by following these steps:

1.  Join observations in `flights` with those in `weather` by `origin`, `year`, `month`, `day`, and `hour`.
2.  Bin `wind_gust` and calculate average `dep_delay` for each bin.
3.  Create a bar graph.

At what gust speeds are departure delays out of NYC the longest on average?

**Note:** This question is based on [13.4.6 \#4](http://r4ds.had.co.nz/relational-data.html#exercises-28). It is designed to strengthen your ability to merge and analyze relational data with [`inner_join()`](http://r4ds.had.co.nz/relational-data.html#inner-join) and [`summarize()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise).

### Solution to Exercise 6

Departure delays are longest when gust speeds are between 35 and 40 mph.

``` r
flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(
    wind_gust_binned   = cut(wind_gust, 
                             breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))
  ) %>%
  group_by(wind_gust_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_binned, y = dep_delay)) +
    geom_col()
```

![](04-data-wrangling-solutions_files/figure-markdown_github/unnamed-chunk-10-1.png)
