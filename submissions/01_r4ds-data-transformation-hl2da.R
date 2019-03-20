library(tidyverse)
library(nycflights13)

# Question1
# How many flights flew into LAX


filter(flights, dest == "LAX")
nrow(filter(flights, dest == "LAX"))

flights %>%
  filter(dest =="LAX") %>%
  nrow()

#HOW many flights flew out of LAX

flights %>%
  filter(origin =="LAX") %>%
  nrow()

#How many flights were longer than or equal to 2,000 miles in distance?
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

# Question2
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

# Question3
flights %>% 
  arrange(desc(is.na(arr_time)))

# Question4
select(flights, contains("TIME"))
# Contains() is case sensitive so this code won't select any column names.
select(flights, contains("TIME", ignore.case = T))

# Question5
flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

