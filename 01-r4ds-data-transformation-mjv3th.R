#install.packages("nycflights13")
library(tidyverse)
library(nycflights13)
view(flights)

#Question 1

laxFlightsIn <- filter(flights, dest == "LAX")
nrow(laxFlightsIn)

laxFlightsOut <- filter(flights, origin == "LAX")
nrow(laxFlightsOut)

longFlights <- filter(flights, distance >= 2000)
nrow(longFlights)

LaFlights <- filter(flights, dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"))
nonJFK <- filter(LaFlights, origin != "JFK")
nrow(nonJFK)

#Question 2

GhostFlights <- filter(flights, !is.na(dept_time), is.na(arr_time))
nrow(GhostFlights)

#Question 3

arrange(flights, desc(is.na(arr_time)))

#Question 4 

select(flights, contains("TIME", ignore.case = FALSE))

#Question 5       
flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

