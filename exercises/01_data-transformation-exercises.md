Data Transformation Exercises
================

The following questions are based on concepts covered in
[Chapter 5](https://r4ds.had.co.nz/transform.html) of R4DS, and answers
to them lie in the `flights` dataset of the nycflights13 package. Load
the tidyverse and nycflights13 packages to start working on them.

``` r
library(tidyverse)
library(nycflights13)
```

-----

**Question 1**: Responding to this set of questions requires two steps:
(a) finding flights that meet certain criteria and (b) counting these
subsets of flights.

  - How many flights flew into LAX?
  - How many flights flew out of LAX?
  - How many flights were longer than or equal to 2,000 miles in
    distance?
  - How many flights were destined for airports in the Los Angeles area
    (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of
    JFK?

**Hint:** For each question, consider filtering the `flights` dataset,
then counting the number of rows that remain using `nrow()`. You might
find it helpful to revisit section
[5.2.1](https://r4ds.had.co.nz/transform.html#comparisons) of R4DS,
which is where Hadley and Garrett review comparison operators. For the
fourth question, consider using the `%in%` operator as well as the
exclamation mark (`!`), which you can vocalize as “not.”

We developed this set of questions based on the first exercise in
section [5.2.4](http://r4ds.had.co.nz/transform.html#exercises-7) of
R4DS. Each is designed to strengthen your ability to use the dplyr verb
[`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter)
effectively.

-----

**Question 2**: How many flights were “ghost flights”? A “ghost flight”
is defined as a flight that departed, but never arrived (i.e., has a
missing value for `arr_time`).

We developed this question based on the third exercise in section
[5.2.4](http://r4ds.had.co.nz/transform.html#exercises-7) of R4DS. It’s
designed to strengthen your understanding of how the dplyr verb
[`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter)
treats `NA` values.

-----

**Question 3**: How does
[`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange)
treat missing values, and how could you sort all of the rows with a
missing `arr_time` to the top of the dataset?

We developed this question based on the first exercise in section
[5.3.1](http://r4ds.had.co.nz/transform.html#exercises-8) of R4DS. It’s
designed to strengthen your understanding of how the dplyr verb
[`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange)
treats `NA` values.

-----

**Question 4**: What do you observe after running the code below? How
does this behavior reflect how
[`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select)
helpers deal with uppercase and lowercase matching by default? How can
you override this default behavior?

``` r
select(flights, contains("TIME"))`
```

We developed this question based on the fourth exercise in section
[5.4.1](http://r4ds.had.co.nz/transform.html#exercises-9) of R4DS. It’s
designed to strengthen your ability to use the dplyr verb
[`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select)
effectively.

-----

**Question 5**: For each destination more than or equal to 2,000 miles
away from NYC’s airports, compute the total number of minutes their
arrivals were delayed. Then, determine how much, as a percentage, each
of these destinations contributed to the total number of arrival-delay
minutes that long-haul destinations (i.e., those more than or equal to
2,000 miles away from NYC’s airports) amassed in 2013. Which three
destinations top the list?

**Hint:** Consider using
[`filter()`](http://r4ds.had.co.nz/transform.html#filter-rows-with-filter)
to find the flights that flew more than or equal to 2,000 miles in
distance and had positive `arr_delay` values. Then,
[`group_by()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise)
`dest`, use
[`summarize()`](http://r4ds.had.co.nz/transform.html#grouped-summaries-with-summarise)
to calculate the total number of arrival-delay minutes by destination,
use
[`mutate()`](http://r4ds.had.co.nz/transform.html#add-new-variables-with-mutate)
to convert this metric into a proportion, use
[`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange)
to lift the top destiations to the top of the list, and use `head()` to
select the top three.

We developed this question based on the fourth exercise in section
[5.7.1](http://r4ds.had.co.nz/transform.html#exercises-12) of R4DS. It’s
designed to strengthen your ability to calculate [per-group proportions
of
totals](http://r4ds.had.co.nz/transform.html#grouped-mutates-and-filters).
