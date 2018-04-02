####Burhan Khan homework 1 data transformation####

####Data transformation exercises####
library(tidyverse)
library(nycflights13)
?flights

#Question 1a: How many flights flew into LAX?
filter(flights, dest == "LAX") %>% nrow()
#Question 1a answer: 16174

#Question 1b: How many flights flew out of LAX?
filter(flights, origin == "LAX") %>% nrow()
#Question 1b answer: 0

#Question 1c: How many flights are greater than or equal to 2000 miles?
filter(flights, distance >= 2000) %>% nrow()
#Question 1c answer: 51695

#Question 1d: How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
filter(flights, dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB") &
         origin != "JFK") %>% nrow()
#Question 1d answer: 5737


#Question 2: How many flights were ghost flights?
filter(flights,  !is.na(dep_time) & is.na(arr_time)) %>% nrow()
#Question 2 answer: 458

#Question 3: How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?
#Arrange treats missing values as if they are the largest number and puts them at the bottom of the row if you use ascending order.  Sort NA's to top of dataset by arranging by descending order of is.na.
arrange(flights, desc(is.na(arr_time), desc(arr_time)))

#Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?
select(flights, contains("TIME"))
#I observed that the select picked all columns with the word "time" in them. Since time was uppercase in the select command and lowercase in the columns, this shows that select by default is case insensitive. You can change that default by using the argument ignore.case = FALSE
select(flights, contains("TIME", ignore.case = FALSE))


#Question 5: For each destination greater than or equal to 2000 miles away, compute total minutes of delay. Also determine what proportion of these total minutes of delay the destinations represent. What are the top-three destinations by proportion of total, and what proportions do each of the top-three destinations represent?
flights %>% filter(distance >= 2000 & dep_delay >= 0) %>% group_by(dest) %>%
  summarize(total_delay = sum(dep_delay, na.rm = T)) %>%
  mutate(proportions = total_delay/sum(total_delay)) %>%
  arrange(desc(proportions))
#Top 3 SFO = 29.6%, LAX = 27.8%, LAS = 10.5%


