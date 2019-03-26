---
author: "Zach Papin"
title: "Data Transformation Solutions"
output: github_document
---



library(tidyverse)
library(nycflights13)
#Question 1: Responding to this set of questions requires two steps: (a) finding flights that meet certain criteria and (b) counting these subsets of flights.

#How many flights flew into LAX?

nrow(filter(flights, dest == 'LAX'))

#How many flights flew out of LAX?

nrow(filter(flights, origin == 'LAX'))

#How many flights were longer than or equal to 2,000 miles in distance?

nrow(filter(flights, distance > 2000))

#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

nrow(filter(flights, dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), origin != "JFK"))

#Question 2:How many flights were "ghost flights"? A "ghost flight" is defined
#as a flight that departed, but never arrived (i.e., has a missing value for
#`arr_time`).

nrow(filter(flights, !is.na(dep_time), is.na(arr_time)))

#Question 3: How does [`arrange()`][arrange] treat missing values, and how could
#you sort all of the rows with a missing `arr_time` to the top of the dataset?
#We developed this question based on the first exercise in section
#[5.3.1][5.3.1Exercises] of R4DS. It's designed to strengthen your understanding
#of how thedplyr verb [`arrange()`][arrange] treats `NA` values.

flights %>% 
  arrange(desc(is.na(arr_time)))
#Question 4: What do you observe after running the code below? How does this
#behavior reflect how [`select()`][select] helpers deal with uppercase and
#lowercase matching by default? How can you override this default behavior?
  
select(flights, contains("TIME",ignore.case = FALSE))
# The code above fails to select any column names because `contains()` is case
# sensitive by default. The following code sets the `ignore.case` argument to
# `TRUE` to select columns that contain "TIME", "time", "TiMe", and so on:
select(flights, contains("TIME", ignore.case = TRUE))



### Question 5 ###

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)
