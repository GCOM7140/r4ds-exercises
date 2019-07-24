library(tidyverse)
library(nycflights13)


#Question 1:

#How many flights flew into LAX?
LAX_inbound <- filter(flights, dest == "LAX")
nrow(LAX_inbound)
#OR
flights %>% 
  filter(dest == "LAX") %>%
  nrow()

#How many flights flew out of LAX?
LAX_outbound <- filter(flights, origin == "LAX")
nrow(LAX_outbound)
#OR
flights %>% 
  filter(origin == "LAX") %>%
  nrow()

#How many flights were longer than or equal to 2,000 miles in distance?
long_dist <- filter(flights, distance >= 2000)
nrow(long_dist)
#OR
flights %>% 
  filter(distance >= 2000) %>%
  nrow()

#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flight_group <- filter(flights, dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB") & origin != "JFK")
nrow(flight_group)
#OR
flights %>% 
  filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB") & origin != "JFK") %>%
  nrow()


#Question 2:

#How many flights were “ghost flights”? A “ghost flight” is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).
ghost_flights <- filter(!is.na(dep_time), is.na(arr_time))
nrow(ghost_flights)
#OR
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time))  %>% 
  nrow()


#Question 3:

#How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?
#Missing values are always sorted at the end:
arrange(flights, desc(is.na(dep_time)))


#Question 4:

#What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?

#Default bheaviour sets ignore.case to TRUE which could be overridden 
select(flights, contains("TIME"))
select(flights, contains("TIME", ignore.case = FALSE))


#Question 5:

##For each destination 
#group_by(dest)

##more than or equal to 2,000 miles away from NYC’s airports
#filter(flights, distance >= 2000)

##compute the total number of minutes their arrivals were delayed
#summarize(group_delay = sum(arr_delay))

##Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC’s airports) amassed in 2013
##proportion = x / sum(x)
#mutate(percentage_delay = group_delay / sum(group_delay))

##Which three destinations top the list?
#top_destinations <- arrange(desc(percentage_delay))
#head(top_destinations)

not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

not_cancelled %>% 
  group_by(dest) %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  summarise(group_delay = sum(arr_delay)) %>%
  mutate(percentage_delay = group_delay / sum(group_delay)) %>%
  arrange(desc(percentage_delay)) %>%
  head(3)

