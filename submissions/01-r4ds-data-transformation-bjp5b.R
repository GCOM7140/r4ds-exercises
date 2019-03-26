#'---
#'__GCOM 7140__
#' title: "r4ds data transformation excercise excercise"
#' author: "Brian J. Policard"
#' date: "March 19, 2019"
#' output: github_document
#' ----------------


library(tidyverse)
library(nycflights13)
# ---------------------
#'Question 1:
#how many flights flew into LAX?

flights %>%
  filter(dest == "LAX") %>%
  nrow()

#how many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow() 
#no flights flew out of LAX (only NYC origin flight data)

# How many flights were destined for airports in the Los Angeles area (LAX, ONT,
# SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>% 
  filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), origin != "JFK") %>% 
  nrow()


#'Question 2: 
#'How many flights were "ghost flights"? A "ghost flight" is defined as a flight
#'that departed, but never arrived (i.e., has a missing value for arr_time).

flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

#458

#'Question 3: 
#'How does arrange() treat missing values, and how could you sort all of the
#'rows with a missing arr_time to the top of the dataset?

#This function arranges all values (missing and non missing) and places all the
#missing ones at the bottom if "desc" isn't specifically used to inverse the
#order in which it displays things.

#'Question 4:
#'What do you observe after running the code below? How does this behavior
#'reflect how select() helpers deal with uppercase and lowercase matching by
#'default? How can you override this default behavior?

#select(flights, contains("TIME"))`

#This should retrieve all columns with the string "TIME" in them butIt doesn't
#work since part of the fucntion is case-sensitive. the "ignore.case = TRUE"
#parameter can be added to this to make the function ignore this and retrieve
#all columns regardless of case


#'Question 5: 
#'For each destination more than or equal to 2,000 miles away from NYC's
#'airports, compute the total number of minutes their arrivals were delayed.
#'Then, determine how much, as a percentage, each of these destinations
#'contributed to the total number of arrival-delay minutes that long-haul
#'destinations (i.e., those more than or equal to 2,000 miles away from NYC's
#'airports) amassed in 2013. Which three destinations top the list?

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

