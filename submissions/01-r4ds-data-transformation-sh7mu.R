library(tidyverse)
library(nycflights13)

# Q1 - How many flights flew into LAX?

flights %>%
  filter(dest == "LAX") %>%
  nrow()

# Q1 - How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()

# Q1 - How many flights were longer than or equal to 2,000 miles in distance?

flights %>%
  filter(distance >= 2000) %>%
  nrow()

# Q1 - How many flights were destined for airports in the Los Angeles area (LAX,
# ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB") 
    & origin != "JFK") %>%
  nrow()


# Q2 - How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived.

flights %>%
  filter(arr_time ) %>%
  nrow()