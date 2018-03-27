library(tidyverse)
install.packages('nycflights13')
library(nycflights13)

# Question 1

# How many flights flew into LAX? 
flights %>%
  filter(dest == 'LAX') %>%
  nrow()
# 16173 flights flew into LAX

# How many flights flew out of LAX?
flights %>%
  filter(origin == 'LAX') %>%
  nrow()
# 0 flights flew out of LAX because this dataset only contains flights departing from NYC

# How many flights are greater than or equal to 2000 miles?
flights %>%
  filter(distance >= 2000) %>%
  nrow()
# 51695 flights are greater than 2000 miles

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flights %>%
  filter(
        dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR",
                        "LGB"), 
        origin != "JFK"
  ) %>%
  nrow()
# 5737 flights destined for LA area that did not originate from JFK

# Question 2
# How many flights were "ghost flights"? 
flights %>%
  filter(is.na(arr_time), !is.na(dep_time)) %>%
  nrow()
# 458 flights are ghost flihgts

# Question 3
# How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?
flights %>%
  arrange(desc(is.na(arr_time)))

# Question 4
# What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?
select(flights, contains("TIME", ignore.case = TRUE))
# The first line of code does not follow the correct syntax for the contains () function. You must add the ignore.case arguement. 

# Question 5
# For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list?
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>%
  head(3)
# SFO, LAX, and LAS have the highest proprotions of departure delay. 