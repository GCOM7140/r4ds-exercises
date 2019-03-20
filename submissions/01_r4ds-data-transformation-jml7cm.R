library(tidyverse)
library(nycflights13)

# Make sure to read the flight data into an object if you want to see all of the variable names and other information. If you are familiar with this dataset or do not need any of this information you can ignore this step. 

dat.flights <- flights

### Question 1 ###

# How many flights flew into LAX?

filter(flights, dest == "LAX")

flights %>%
  filter(dest == "LAX") %>%
  nrow()

# How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()

# How many flights were longer than or equal to 2,000 miles in distance?

flights %>%
  filter(distance >= 2000) %>%
  nrow()

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"),
    origin != "JFK"
  ) %>%
  nrow()

### Question 2 ###


