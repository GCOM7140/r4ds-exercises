library(tidyverse)
library(nycflights13)

## Question 1 ##
# A) How many flights flew into LAX

nrow(filter(flights ,dest == "LAX"))

# OR

flights %>%
  filter(dest == "LAX") %>%
  nrow()

# B) How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()

# C) How many flights were longer than or equal to 2,000 miles in distance?

flights %>%
  filter(distance >= 2000) %>%
  nrow()

# D) How many flights were destined for airports in the LA area (LAX, ONT, SNA,  PSP, SBD, BUR, or LGB) but did not originate out of JFK

la_airports <- c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")

flights %>%
  filter(origin != "JFK", dest %in% la_airports) %>%
  nrow()

## Question 2 - How many flights were ghost flights?

flights %>%
  filter(is.na(arr_time), !is.na(dep_time)) %>%
  nrow()
str(flights)

## Question 3 - How does arrange() treat missing values, and how could you sort all of the rows with a
