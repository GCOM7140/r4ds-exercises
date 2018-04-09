#' ---
#' title: "Answers to the R4DS Data Transformation Exercise"
#' author: Jeff Boichuk
#' date: March 29, 2018
#' output: github_document
#' ---

library(tidyverse)
library(nycflights13)

#' **Question 1**: The following questions ask you to find flights that meet
#' certain criteria and then count them.  

#' -   How many flights flew into LAX?  

flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()

#' -   How many flights flew out of LAX?  

flights %>% 
  filter(origin == 'LAX') %>% 
  nrow()

#' -   How many flights are greater than or equal to 2000 miles?  

flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

#' -   How many flights were destined for airports in the Los Angeles area 
#' (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?  

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

#' **Question 2**: How many flights were "ghost flights"? A "ghost flight" is
#' defined as a flight that departed, but never arrived (i.e., has a missing
#' `arr_time`).  

flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

#' **Question 3**: How does
#' [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange)
#' treat missing values? How could you sort all rows with a missing `arr_time`
#' to the top of the dataset?  

#'  
#' With the arrange function, all non-missing values get sorted in ascending or
#' descending fashion; then rows with missing values get displayed. The
#' following code brings missing values to the top, then sorts the observations
#' in descending order:

flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))

#' **Question 4**: What do you observe after running the code below? How does
#' this behavior reflect how
#' [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select)
#' helpers deal with uppercase and lowercase matching by default? How can you
#' change that default?

select(flights, contains("TIME"))

#' The referenced code selects six columns in the `flights` dataset, because the
#'  `contains()` function is not case-sensitive by default. You can set the
#' `ignore.case` argument to `FALSE` to change this behavior as follows:

select(flights, contains("TIME", ignore.case = FALSE))

#' **Question 5**: For each destination greater than or equal to 2000 miles
#' away, compute total minutes of departure delay. Then determine what
#' proportion of total-departure-delay minutes each destination represents. What
#' three destinations top the list?

flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)
