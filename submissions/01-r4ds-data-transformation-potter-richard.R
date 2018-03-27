# Richard Potter
# Data Transformation R4DS Homework Assignment
# Professor Boichuk
# 27 March 2018

library(tidyverse)
library(nycflights13)
?flights


# Question 1 --------------------------------------------------------------
#Part A
#Calculating the number of flights departing for LAX.
nrow(filter(flights, dest == "LAX"))
#16,174

#Part B
#Calculating the number of flights departing from LAX.
filter(flights, origin == "LAX")
# 0, which is logical since the data is about NYC departures

#Part C
#Caluclating the number of flights longer than 2000 miles.
nrow(filter(flights, distance >= 2000))
#51,695

#Part D
#Calculating the number of flights not departing JFK which are bound for
# "LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"
nrow(flights %>%
  filter(origin != "JFK") %>%
  filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")))
#5,737


# Question 2 --------------------------------------------------------------
#Calcualting the number of ghost flights.
nrow(flights %>% 
  filter(is.na(arr_time)) %>% 
  filter(is.finite(dep_time)))
#458


# Question 3 --------------------------------------------------------------
#Placing flights with missing arrival times at the top.
arrange(flights, desc(is.na(arr_time)))
# Missing values are placed at the end, when is.na is not used.


# Question 4 --------------------------------------------------------------
#Seeing what happens when time is searched for.
select(flights, contains("TIME"))
?select
#This search looked for all cases of time, both upper and lower. To change from
#the default, one must apply the ignore.true = FALSE condition within the
#contains statement.


# Question 5 --------------------------------------------------------------
# Finding the destinations with the highest proportion of delays which are
# longer than 2000 miles in distance.
flights %>%
  filter(distance > 2000) %>%
  filter(dep_delay > 0) %>%
  group_by(dest) %>%
  summarise(delaytime = sum(dep_delay, na.rm = T)) %>%
  mutate(propdelay = delaytime/sum(delaytime)) %>%
  arrange(desc(propdelay))
# Top 3 Delay Proportions: SFO, LAX, LAS
# Proportions: .296, .278, .105

