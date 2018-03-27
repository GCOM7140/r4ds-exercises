#----------------------------------------------------------------
#Rich Eldh
#Professor Boichek
#Customer Analytics
#Assignment #1
#Due Date: 27 March 2018
#----------------------------------------------------------------

#----------------------------------------------------------------
#R4DS Exercise
#----------------------------------------------------------------


library(tidyverse)
library(nycflights13)


#----------------------------------------------------------------
#Question 1
#----------------------------------------------------------------

flightsdestLAX <- filter(flights, dest == 'LAX')
nrow(flightsdestLAX)
#16,174

flightsoriginLAX <- filter(flights, origin == 'LAX')
nrow(flightsoriginLAX)
#0

flights %>% 
  filter(distance >= 2000)
#51,695

flights %>%
  filter(origin != 'JFK', dest %in% c('LAX', 'ONT', 'SNA', 'PSP', 'SBD', 'BUR', 'LGB'))
#5,737

#----------------------------------------------------------------
#Question 2
#----------------------------------------------------------------

flights %>%
  filter(is.na(arr_time))
#8,713

#----------------------------------------------------------------
#Question 3
#----------------------------------------------------------------

flights %>%
  arrange(desc(is.na(arr_time)))

#----------------------------------------------------------------
#Question 4
#----------------------------------------------------------------

select(flights, contains("time"))

#----------------------------------------------------------------
#Question 5
#----------------------------------------------------------------

dist.2000 <- filter(flights, distance >= 2000, !is.na(dep_delay))
depart.delay <- select(dist.2000, dest, dep_delay)

depart.delay %>% 
  group_by(dest) %>%
  summarize(total = sum(dep_delay)) %>% 
  mutate( 
    prop_dep_delay = total/sum(total)
  ) %>% 
  arrange(desc(prop_dep_delay))
#1: SFO (.305), 2: LAX (.271), 3: LAS (.101)
