Data Wrangling Exercises
================
Richard Potter
17 April 2018

``` r
library(tidyverse)
library(nycflights13)
```

Also, run `?flights` and `?who` in the console to (re)familiarize yourself with these datasets.

------------------------------------------------------------------------

Exercise 1:
-----------

\`people &lt;- tribble( ~name, ~key, ~value, \#---------------/---------/-------- "Ousmane Diaby", "age", 23, "Ousmane Diaby", "height", 196, "Ousmane Diaby", "age", 33, "Rich Eldh", "age", 23, "Rich Eldh", "height", 195 )

people %&gt;% spread(key, value)\`

**Question**: Why can't you spread `people`? How could you add a new column to `people` to fix the problem?

**Answer**: People cannot be spread as there is a duplicate value for age in the data set. This problem can be solved with the addition of another column such as time, so that there can be different unique values. See below for an example evaluation.

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
  group_by(name, key) %>% 
  mutate(time = row_number()) %>% 
  spread(key, value)
```

    ## # A tibble: 3 x 4
    ## # Groups:   name [2]
    ##   name           time   age height
    ##   <chr>         <int> <dbl>  <dbl>
    ## 1 Ousmane Diaby     1   23.   196.
    ## 2 Ousmane Diaby     2   33.    NA 
    ## 3 Rich Eldh         1   23.   195.

------------------------------------------------------------------------

Exercise 2:
-----------

``` r
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
```

**Question**: Do you need to gather or spread `preg` to tidy it? What variables are there in `preg`?

**Answer**: This data will need to be gathered as there are values as variable names. See below for the changed code.

------------------------------------------------------------------------

Exercise 3:
-----------

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

**Question**: How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the `separate()` function call. What could they do to remedy the situation?

**Answer**: R was expecting that there would be three equal rows, of three columns each. However, there was information for a fourth column in the second set, which R was not expecting. The best way to solve this issue would be to change the extra setting to merge, instead of the default warn. Please see the attached code below for a corrected version.

``` r
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")
```

    ## # A tibble: 3 x 3
    ##   one   two   three
    ##   <chr> <chr> <chr>
    ## 1 a     b     c    
    ## 2 d     e     f,g  
    ## 3 h     i     j

------------------------------------------------------------------------

Exercise 4:
-----------

**Question**: Both `separate()` and `unite()` have a `remove` argument. What does it do? When does setting it to `FALSE` make sense?

**Answer**: The remove argument removes the original columns, and is the default setting in R. False would be appropriate in cases where we may want to debug the code, or perform additional analysis in a different manner in the table.

------------------------------------------------------------------------

Exercise 5:
-----------

**Question**: Using the `who` dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?

**Answer**: See below for the analysis and plot. I am surprised by the growth of the cases in all of the countries, as well as the massive spike in India.

``` r
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year) %>% 
  summarise(cases = sum(value)) %>% 
  filter(country %in% c("China", "India", "Bangladesh")) %>% 
  ggplot(aes(x = year, y = cases, color = country)) + 
    geom_point() + 
    geom_line()
```

------------------------------------------------------------------------

Exercise 6:
-----------

**Question**: Begin by following these steps: 1. Join observations in `flights` with those in `weather` by `origin`, `year`, `month`, `day`, and `hour`.
2. Bin `wind_gust` and calculate average `dep_delay` for each bin.
3. Create a bar graph. At what gust speeds are departure delays out of NYC the longest on average?

**Answer**: See below for the code. Delays are the longest on average when wind gusts are between 39 and 42 MPH.
