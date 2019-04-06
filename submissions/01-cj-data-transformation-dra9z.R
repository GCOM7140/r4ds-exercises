#install.packages("tidyverse")
#install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

#Question 1: Responding to this set of questions requires two steps: (a) finding flights that meet certain criteria and (b) counting these subsets of flights.

# How many flights flew into LAX?
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()
#How many flights flew out of LAX?

flights %>% 
  filter(origin == "LAX") %>% 
  nrow()

#How many flights were longer than or equal to 2,000 miles in distance?

#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?