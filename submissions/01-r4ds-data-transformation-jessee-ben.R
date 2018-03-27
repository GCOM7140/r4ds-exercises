library(tidyverse)
library(nycflights13)

#1

#Into LAX
flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()

#Out of LAX
flights %>% 
    filter(origin == 'LAX') %>% 
    nrow()

#>= 2000 miles
flights %>% 
    filter(distance >= 2000) %>% 
    nrow()

#Destined for LA
flights %>% 
    filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
     ) %>% 
    nrow()

#2
flights %>% 
    filter(is.na(arr_time), !is.na(dep_time)) %>% 
    nrow()

#3
flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))

#4
select(flights, contains("TIME", ignore.case = TRUE))

#5
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)