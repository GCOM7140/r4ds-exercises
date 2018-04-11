library(tidyverse)
library(nycflights13)
library(dplyr)
library(utils)
#Question 1
str(flights)
filter(flights, dest == "LAX")
#Flights into LA numbered 16,174
flights.to.LAX <- filter(flights, origin == "LAX")
flights.to.LAX
# zero. Not contianed in Dataset because we are only given origins for flights out of NYC

filter(flights, distance >= 2000)

 #51,695

filter(flights, dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), origin != "JFK")
#5,737

#Question 2

filter(flights, !is.na(dep_time) & is.na(arr_time))
#458

#Question 3
flights %>%
  arrange(desc(is.na(arr_time)))
# 336,776

# Question 4
select(flights, contains("TIME"))

?contain
#Contains() is a function with a default parameter set for ignore.case = TRUE. Changing this to false makes it case sensitive.
select(flights, contains("TIME", ignore.case = FALSE))

# Question 5

flights %>%
  filter(distance >= 2000 & dep_delay != 0) %>%
  group_by(dest) %>%
  summarize(Total_delay_by_dest = sum(dep_delay)) %>%
  mutate(delay_prop = Total_delay_by_dest / sum(Total_delay_by_dest)) %>%
  arrange(desc(delay_prop)) %>%
  head(n = 3L)
#Top 3 are SFO with .305, LAX with .271, and LAS with .101  
  





