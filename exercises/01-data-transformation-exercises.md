Data Transformation Exercises
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

------------------------------------------------------------------------

**Question 2**: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing `arr_time`).

This question is based on [5.2.4\#3](http://r4ds.had.co.nz/transform.html#exercises-7) and designed to strengthen your understanding of how the `dplyr` verb [`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter) treats `NA` values.

------------------------------------------------------------------------

**Question 3**: How does [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) treat missing values? How could you sort all rows with a missing `arr_time` to the top of the dataset?

This question is based on [5.3.1\#1](http://r4ds.had.co.nz/transform.html#exercises-8) and designed to strengthen your understanding of how the `dplyr` verb [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) treats `NA` values.

------------------------------------------------------------------------

**Question 4**: What do you observe after running the code below? How does this behavior reflect how [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select) helpers deal with uppercase and lowercase matching by default? How can you change that default?

``` r
select(flights, contains("TIME"))`
```

This question is based on [5.4.1\#4](http://r4ds.had.co.nz/transform.html#exercises-9) and designed to strengthen your ability to use the `dplyr` verb [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select).

------------------------------------------------------------------------

**Question 5**: For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Also determine what proportion of these total minutes of departure delay the destinations represent. What are the top-three destinations by proportion of total departure delay, and what proportions do each of the top-three destinations represent?

**Hint:** Use [`summarize()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise) and [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange) to find the top three.

This question is based on [5.7.1\#4](http://r4ds.had.co.nz/transform.html#exercises-12) and designed to strengthen your ability to calculate a per-group percentage of a total. See [here](http://r4ds.had.co.nz/transform.html#grouped-mutates-and-filters).
