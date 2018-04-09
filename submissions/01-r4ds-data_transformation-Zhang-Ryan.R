library(tidyverse)
library(nycflights13)

flights <- flights

# Question 1
# How many flights flew into LAX?
nrow(
  flights %>% 
  filter(dest == "LAX"))
# 16174

#How many flights flew out of LAX?
nrow(
  flights %>% 
  filter(origin == "LAX"))
# 0

#How many flights are greater than or equal to 2000 miles?
nrow(
  flights %>% 
  filter(distance > 2000))
# 51695

#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
nrow(
  flights %>% 
  filter(dest %in% c('LAX', 'ONT', 'SNA', 'PSP', 'SBD', 'BUR', 'LGB') & !(origin == 'JFK')))
# 5737

# Question 2
#  How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived.

nrow(
  filter(flights, !(is.na(dep_time)) & is.na(arr_time))
)
# 458

# Question 3: 
#How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?

arrange(
  flights, desc(is.na(arr_time)), 
)

# Question 4
# What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?

select(flights, contains("TIME"))
#It selects out columns containing "time"
# It ignores the difference of uppercase and lowercase

select(flights, contains("time", ignore.case = FALSE))

# Question 5: 
#For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list?

arrange(
  flights %>% 
  filter(distance == 2000 | distance >2000) %>% 
  filter(dep_delay > 0) %>% 
  group_by(dest) %>% 
  summarize(total_dep_delay = sum(dep_delay)) %>% 
  mutate(prop_delay=total_dep_delay/sum(total_dep_delay))
, desc(prop_delay))
#SFO, LAX, LAS
