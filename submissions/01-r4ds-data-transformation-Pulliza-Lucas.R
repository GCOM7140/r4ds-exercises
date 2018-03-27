library(tidyverse)
library(nycflights13)
install.packages('nycflights13')
?flights
summary(flights)

#########################################################################
# Question 1:
# Flights into LAX = 16,174
flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()

# FLights out of LAX = 0
flights %>% 
  filter(origin == 'LAX') %>% 
  nrow()

# How many flights are greater than or equal to 2000 miles
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

# How many flights were destined for airports in Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, LGB) but did originate out of JFK?
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

# Question 2: # Ghost Flights
flights %>% 
  filter(is.na(arr_time), !is.na(dep_time)) %>% 
  nrow()

# Question 3 Sort flights with missing arrival time at top of data set
flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))

# Quesition 4
select(flights, contains("TIME"))
select(flights, contains("TIME", ignore.case = TRUE))

# Question 5 total departure delay on flights greater than 2,000 miles
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)


