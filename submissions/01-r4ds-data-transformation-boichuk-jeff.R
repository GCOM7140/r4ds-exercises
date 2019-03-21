#' #' ---
#' title: "Answers to the R4DS Data Transformation Exercises"
#' author: Jeff Boichuk
#' date: `r Sys.Date()`
#' output: github_document
#' ---

library(tidyverse)
library(nycflights13)

#' Question 1: Responding to this set of questions requires two steps: (a)
#' finding flights that meet certain criteria and (b) counting these subsets of
#' flights.

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