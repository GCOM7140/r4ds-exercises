library(tidyverse)
library(nycflights13)

#Question 1: Responding to this set of questions requires two steps: (a) finding flights that meet certain criteria and (b) counting these subsets of flights.

#How many flights flew into LAX?

nrow(filter(flights, dest == 'LAX'))

flights %>% 
  filter(dest == 'LAX') 

#How many flights flew out of LAX?

flights %>% 
  filter(origin == 'LAX') 
