#######################################
##  Customer Analytics:              ##
##  R4DS Data Transformation         ##
##  Exercise 1                       ##
##  Creator: Sebastian Cook          ##
##  20th March, 2019                 ##
#######################################


library(tidyverse)
library(nycflights13)


### Question 1: ###

# 1a) How many flights flew into LAX?

flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

# Ans: 16174

# 1b) How many flights flew out of LAX?

flights %>% 
  filter(origin == "LAX") %>% 
  nrow()

# Ans: 0, all flights from NYC

# 1c) How many flights were longer than or equal to 2,000 miles in distance?

flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

# Ans: 51695

# 1d) How many flights were destined for airports in the Los Angeles area (LAX, ONT, 
# SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

# Ans: 5737

### Question 2: ###
# How many flights were "ghost flights"? A "ghost flight" is defined as a flight 
# that departed, but never arrived (i.e., has a missing value for `arr_time`)

flights %>% 
  arrange(desc(is.na(arr_time)))

# Ans: 10 flights have an N/A value for arrival time, thus being "ghost flights".

### Question 3: ###
# What do you observe after running the code below? How does this behavior reflect 
# how [`select()`][select] helpers deal with uppercase and lowercase matching by 
# default? How can you override this default behavior? 

```{r include = TRUE, eval = FALSE}
select(flights, contains("TIME"))`
```

?contains

# An error message comes up because of an unexpected symbol in the 'select' portion of the code.
# Also, once I queried 'contains', I found that it is case sensitive, and with the 3rd portion
# of the code being unfulfilled, the default is that case is accounted for.
# The following is a simple modification of this to make it work better:

select(flights, contains("Time", TRUE))


### Question 5: ###
# For each destination more than or equal to 2,000 miles away from NYC's airports,
# compute the total number of minutes their arrivals were delayed. Then, determine
# how much, as a percentage, each of these destinations contributed to the total
# number of arrival-delay minutes that long-haul destinations (i.e., those more
# than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which
# three destinations top the list?

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

# Ans: SFO, LAX, and LAS have the largest total delay minutes, for destinations more than
# 2000 miles away from NYC.