library(tidyverse)
library(nycflights13)

#1
# How many flights flew into LAX?
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

#2
# How many flights flew out of LAX?
flights %>% 
  filter(origin == "LAX") %>% 
  nrow()

#3
# How many flights were longer than or equal to 2,000 miles in distance?
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

#4
# How many flights were destined for airports in the Los Angeles area (LAX, ONT, 
# SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()