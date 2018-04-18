install.packages('tidyverse')
install.packages('nycflights13')

library(tidyverse)
library(nycflights13)



#Question 1: The following questions ask you to find flights that meet certain criteria and then count them.

#How many flights flew into LAX? Ans: 16174

flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()

#How many flights flew out of LAX? Ans: 0

flights %>%
  filter(origin == 'LAX') %>%
  nrow()

#How many flights are greater than or equal to 2000 miles? Ans:220021

flights %>%
  filter( distance >= '2000') %>%
  nrow()

#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK? Ans:5737

flights %>%
  filter( dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"),
          origin != 'JFK') %>%
  nrow()

#Question 2: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing arr_time). Ans: 458

flights %>% 
  filter(is.na(arr_time), !is.na(dep_time)) %>% 
  nrow()

#Question 3: How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?

flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))

#Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?

#select(flights, contains("TIME"))`
#does not run because the contains () function is case sensitive

select(flights, contains("TIME", ignore.case = TRUE))

#Question 5: For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list? Top 3 Destinations: ORD, ATL, SFO

flights %>%
  filter( distance >= '2000', dep_delay >0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)