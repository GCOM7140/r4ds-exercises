##### Dowling George Homework 1####

library(tidyverse)
library(nycflights13)

str(flights)
head(flights)


####Question 1####

#Flights into LAX
flights %>%
  filter(dest == "LAX") %>%
  summarise(length(arr_time) - sum(is.na(arr_time)))

#Flights out of LAX
flights %>%
  filter(dest == "LAX") %>%
  summarise(length(dep_time) - sum(is.na(dep_time)))

#Flights greater than 2000 miles
flights %>%
  filter(flight > 2000) %>%
  summarise(length(flight))

#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), origin != "JFK") %>%
  summarise(length(flight))


####Question 2####

#Number of Ghost Flights 

flights %>%
  filter(!is.na(dep_time) & is.na(arr_time)) %>%
  summarise(length(dep_time))
  

#### Question 3 ####
flights %>%
  arrange(desc(is.na(arr_time)))%>%
  select(arr_time)
  
#### Question 4 ####
select(flights, contains("TIME"))

#### Question 5 ####
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarise(dep_delay_sum = sum(dep_delay)) %>%
  mutate(delay_proportion = dep_delay_sum / sum(dep_delay_sum)) %>%
  arrange(desc(delay_proportion)) %>%
  head(3)
  