install.packages("nycflights13")

library(devtools)
library(nycflights13)


library(tidyverse)

########################## QUESTION 1 ####################################
#1 How many flights flew into LAX?
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

#2 How many flights flew out of LAX?
flights %>% 
  filter(origin == "LAX") %>% 
  nrow()

#3 How many flights were longer than or equal to 2,000 miles in distance?
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

#4 How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

##############################QUESTION 2#########################

flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

##############################QUESTION 3######################################

flights %>% 
  arrange(desc(is.na(arr_time)))

##############################QUESTION 4#######################################

select(flights, contains("TIME"))

###################################### QUESTION 5 ##############################
flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)