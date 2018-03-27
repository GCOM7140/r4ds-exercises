install.packages("nycflights13")
library(tidyverse)
library(nycflights13)

?flights
str(flights)
#Question 1a: How many flights flew into LAX?

flights_to_LAX <- nrow(filter(flights, dest == 'LAX'))
flights_to_LAX

#Question 1b:How many flights flew out of LAX?

flights_from_LAX <- nrow(filter(flights, origin == 'LAX'))
flights_from_LAX

#Question 1c:How many flights are greater than or equal to 2000 miles?

long_flights <- nrow(filter(flights, distance >= 2000))
long_flights

#Question 1d:How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights_not_from_JFK <-nrow(filter(flights, dest %in% c('LAX', 'ONT', 'SNA', 'PSP', 'SBD', 'BUR', 'LGB'), origin != 'JFK' )) 
flights_not_from_JFK

#Question 2: How many flights were "ghost flights"? 
ghost_flight <- nrow(filter(flights, is.na(arr_time)))
ghost_flight

#Question 3: How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?
arrange(flights)
missing_set <- flights %>% 
  arrange(desc(is.na(arr_time)))
missing_set

#Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?
#Looks like it gives any variable with 'time' regardless of case. You can specify the word you're looking for by using scoped variants such as select_all, select_if, and select_at. 
select(flights, contains("TIME"))
select(flights, contains("TIME", ignore.case = FALSE)) 

#Question 5: For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list?
delayed_flights <- flights %>% 
  select(dest, everything()) %>% 
  filter(
    distance >= 2000,
    dep_delay > 0
    ) %>% 
  group_by(dest) %>% 
  summarize(total_delay = sum(dep_delay)) %>% 
  mutate(prop_delay = total_delay / sum(total_delay)) %>% 
  arrange(desc(prop_delay))
head(delayed_flights)



