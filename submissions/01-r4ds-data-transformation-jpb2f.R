#' ---
#' title: "Answers to the R4DS Data Transformation Exercises"
#' author: 
#' date: 
#' output: github_document
#' ---

library(tidyverse)
library(nycflights13)

#' __Question 1__: Responding to this set of questions requires two steps: (a)
#' finding flights that meet certain criteria and (b) counting these subsets of
#' flights.  
#' 
#' How many flights flew into LAX?

flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

#' How many flights flew out of LAX?

flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

#' How many flights were longer than or equal to 2,000 miles in distance?

flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

#' How many flights were destined for airports in the Los Angeles area (LAX,
#' ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

#' __Question 2__: How many flights were “ghost flights”? A “ghost flight” is
#' defined as a flight that departed, but never arrived (i.e., has a missing
#' value for `arr_time`).

flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

#' __Question 3__: How does `arrange()` treat missing values, and how could you
#' sort all of the rows with a missing `arr_time` to the top of the dataset?

# With the arrange() function, all non-missing values get sorted in ascending or
# descending fashion; then rows with missing values get displayed. The following
# code brings the missing values to the top with `desc(is.na(arr_time))`:

flights %>% 
  arrange(is.na(arr_time) %>% desc())

#' Question 4: What do you observe after running the code below? How does this
#' behavior reflect how select() helpers deal with uppercase and lowercase
#' matching by default? How can you override this default behavior?

select(flights, contains("TIME"))

# The code above selects columns in the flights dataset that contain the letter
# t followed by i, m, and e. Importantly, the variable names could contain
# "TIME", "time", "TiMe", and so on, because the select() helper contains() is
# not case sensitive by default. The following code sets the `ignore.case`
# argument to `FALSE` to inhibit this functionality.

select(flights, contains("TIME", ignore.case = FALSE))
