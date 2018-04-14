Data Wrangling Exercises
================

The following six exercises are based on concepts covered in [Chapter 12](http://r4ds.had.co.nz/tidy-data.html) and [Chapter 13](http://r4ds.had.co.nz/relational-data.html) of [R for Data Science](http://r4ds.had.co.nz/). Use the `flights` and `who` datasets that come with the `tidyverse` package to work on them, and start by loading the `tidyverse`.

``` r
library(tidyverse)
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

------------------------------------------------------------------------

Exercise 4
----------

Both [`separate()`](http://r4ds.had.co.nz/tidy-data.html#separate) and [`unite()`](http://r4ds.had.co.nz/tidy-data.html#unite) have a `remove` argument. What does it do? When does setting it to `FALSE` make sense?

**Note:** This question is based on [12.4.3 \#2](http://r4ds.had.co.nz/tidy-data.html#exercises-23). It is designed to strengthen your ability to parse columns while making use of arguments such as `remove`.

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

**Note:** This question is based on [12.6.1 \#4](http://r4ds.had.co.nz/tidy-data.html#exercises-25). It is designed to strengthen your ability to create a pipeline full of data wrangling and visualization operations.

------------------------------------------------------------------------

Exercise 6
----------

Begin by following these steps:

1.  Join observations in `flights` with those in `weather` by `origin`, `year`, `month`, `day`, and `hour`.
2.  Bin `wind_gust` and calculate average `dep_delay` for each bin.
3.  Create a bar graph.

At what gust speeds are departure delays the longest on average?

**Note:** This question is based on [13.4.6 \#4](http://r4ds.had.co.nz/relational-data.html#exercises-28). It is designed to strengthen your ability to merge and analyze relational data with [`inner_join()`](http://r4ds.had.co.nz/relational-data.html#inner-join) and [`summarize()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise).
