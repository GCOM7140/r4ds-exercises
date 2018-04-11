#Data Transformation Exercise - nycflights
#Yuansong(Kecin) Wu

install.packages('tidyverse')
install.packages('nycflights13')

library(tidyverse)
library(nycflights13)

#Q1
flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()

flights %>% 
  filter(origin == 'LAX') %>% 
  nrow()

flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

#Q2
flights %>% 
  filter(is.na(arr_time), !is.na(dep_time)) %>% 
  nrow()

#Q3
flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))

#Q4
select(flights, contains("TIME", ignore.case = TRUE))

#Q5
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(delay_mins = sum(dep_delay)) %>%
  mutate(delay_proportion = delay_mins / sum(delay_mins)) %>%
  arrange(-delay_proportion) %>% 
  head(3)

