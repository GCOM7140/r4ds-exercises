
install.packages('nycflights13')
library(tidyverse)
library(nycflights13)
?flights

#Question 1
#1 How many flights flew into LAX?
nrow(filter(flights, dest == 'LAX')) #16174
#2 How many flights flew out of LAX?
nrow(filter(flights, origin == 'LAX')) #0
#3 How many flights are greater than or equal to 2000 miles?
nrow(filter(flights, distance >= 2000)) #51695
#4 How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
nrow(filter(flights, dest %in% c('LAX', 'ONT', 'SNA', 'PSP', 'SBD', 'BUR', 'LGB') & !(origin == 'JFK'))) #5737

#Question 2: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing arr_time).
nrow(filter(flights, !is.na(dep_time), is.na(arr_time))) #458

#Question 3: How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?
#arrange() orders all the missing values at the bottom.
#in order to sort all the missing values at the top:
arrange(flights, desc(is.na(arr_time)))

#Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?
select(flights, contains("TIME")) 
#select function is not case sensitive
select(flights, contains("TIME", ignore.case = FALSE))

#Question 5: For each destination greater than or equal to 2000 miles away, compute total minutes of delay. Also determine what proportion of these total minutes of delay the destinations represent. What are the top-three destinations by proportion of total, and what proportions do each of the top-three destinations represent?

flights %>%
  filter(distance >= 2000 & dep_delay != 0)%>%
  group_by(dest) %>%
  summarise(delay_by_dest = sum (dep_delay)) %>%
  mutate(delay_prop = delay_by_dest / sum (delay_by_dest)) %>%
  arrange(desc(delay_prop)) %>%
  head(3)



