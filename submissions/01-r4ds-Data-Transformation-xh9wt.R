install.packages('tidyverse')
install.packages('nycflights13')

library(tidyverse)
library(nycflights13)

# Q1: The following questions ask you to find flights that meet certain criteria and then count them.

# How many flights flew into LAX? 

flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()
# Ans: 16174

# How many flights flew out of LAX?

flights %>%
  filter(origin == 'LAX') %>%
  nrow()
# Ans: 0

# How many flights are greater than or equal to 2000 miles? 

flights %>%
  filter( distance >= '2000') %>%
  nrow()
# Ans:220021

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK? 

flights %>%
  filter( dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"),
          origin != 'JFK') %>%
  nrow()
# Ans:5737

# Q2: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing arr_time). 

flights %>% 
  filter(is.na(arr_time), !is.na(dep_time)) %>% 
  nrow()
# Ans: 458

# Q3: How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?

flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))

# Q4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?

# select(flights, contains("TIME"))`
# does not run because the contains () function is case sensitive

select(flights, contains("TIME", ignore.case = TRUE))

# Q5: For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list? 

flights %>%
  filter( distance >= '2000', dep_delay >0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)
# Top 3 Destinations: ORD, ATL, SFO