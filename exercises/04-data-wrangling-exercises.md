Data Wrangling Exercises
================

The following 6 questions are based on concepts covered in Chapters 12-13 in R4DS. The questions will center around the `flights` dataset from the `nycflights13`, the `who` dataset from the `tidyr` package, and a few small example datasets. Start by loading the `tidyverse` and `nycflights13` packages. The `tidyr` package is loaded by default when the tidyverse is loaded.

``` r
library(tidyverse)
library(nycflights13)
```

It is highly recommended to run `?flights` and `?who` from the R console to first familiarize yourself with the datasets.

------------------------------------------------------------------------

**Question 1**: Why does spreading this tibble fail? How could you add a new column to fix the problem? Hint: You can create an indicator column to uniquely identify each observation using the row number like this: `mutate(obs = row_number())`

``` r
people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

people %>% 
  spread(key, value)
```

    ## Error: Duplicate identifiers for rows (1, 3)

*This question is [12.3.1.\#3](http://r4ds.had.co.nz/tidy-data.html#exercises-22) and grows your understanding of how `spread()` behaves with non-unique rows [(link)](http://r4ds.had.co.nz/tidy-data.html#spreading).*

------------------------------------------------------------------------

**Question 2**: Do you need to spread or gather the tibble below to tidy it? What are the variables?

``` r
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
```

*This question is [12.3.1.\#4](http://r4ds.had.co.nz/tidy-data.html#exercises-22) and grows your understanding of what "gathering" a dataset means [(link)](http://r4ds.had.co.nz/tidy-data.html#gathering).*

------------------------------------------------------------------------

**Question 3**: Running the following code generates a warning message. What does this message mean? Provide two ways to incorporate all of the data.

``` r
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))
```

    ## Warning: Too many values at 1 locations: 2

    ## # A tibble: 3 x 3
    ##   one   two   three
    ## * <chr> <chr> <chr>
    ## 1 a     b     c    
    ## 2 d     e     f    
    ## 3 h     i     j

*This question is [12.4.3.\#1](http://r4ds.had.co.nz/tidy-data.html#exercises-23) and grows your ability to separate (parse) a column [(link)](http://r4ds.had.co.nz/tidy-data.html#separate).*

------------------------------------------------------------------------

**Question 4**: Both `unite()` and `separate()` have a `remove` argument. What does it do? Why would you set it to FALSE?
*This question is [12.4.3.\#2](http://r4ds.had.co.nz/tidy-data.html#exercises-23) and grows your understanding of how arguments can be used for finer control when parsing a column [(link)](http://r4ds.had.co.nz/tidy-data.html#spreading-and-gathering).*

------------------------------------------------------------------------

**Question 5**: Using the `who` dataset, find the total number of cases of TB each year for China, India, and Bangladesh, and plot the data over time. Do you notice anything surprising? Hint: First, run the code block below to generate a cleaned dataset and answer the question using that `clean_who` dataset.

``` r
clean_who <- who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)
```

*This question is based on [12.6.1.\#4](http://r4ds.had.co.nz/tidy-data.html#exercises-25) and grows your ability to create a full wrangling pipeline and generate results [(link)](http://r4ds.had.co.nz/tidy-data.html#case-study).*

------------------------------------------------------------------------

**Question 6**: What weather conditions make it more likely to see a departure delay? Hint: Your answer should follow these steps:

1.  Join observations existing in both `flights` with `weather` based on `origin`, `year`, `month`, `day`, and `hour`
2.  Bin `wind_gust` and find the average `dep_delay` for different levels of gusts
3.  Create create a plot

*This question is based on [13.4.6.\#4](http://r4ds.had.co.nz/relational-data.html#exercises-28) and grows your ability to use an inner join before summarizing data [(link)](http://r4ds.had.co.nz/relational-data.html#inner-join).*
