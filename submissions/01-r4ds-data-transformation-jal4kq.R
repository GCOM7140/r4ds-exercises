library(tidyverse)
library(nycflights13)




#####  **Question 1**  #####

# How many flights flew into LAX?
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()
# How many flights flew out of LAX?
flights %>% 
  filter(origin == "LAX") %>% 
  nrow()
# This is a bit of a trick question. You can confirm that the correct answer is
# zero by running ?flights. The dataset description states: "On-time data for
# all flights that *departed* NYC (i.e. JFK, LGA or EWR)" (emphasis added). LAX
# is the airport code for Los Angeles International Airport, so zero flights in
# this dataset originated from LAX.
# How many flights were longer than or equal to 2,000 miles in distance?
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()
# How many flights were destined for airports in the Los Angeles area (LAX, ONT, 
# SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()




#####  **Question 2**  #####


flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()




#####  **Question 3**  #####

flights %>% 
  arrange(desc(is.na(arr_time)))



---
  
  #####  **Question 4**  #####


select(flights, contains("TIME", ignore.case = TRUE))



####  **Question 5**  ####

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)


