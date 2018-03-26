## Chapter 5 R4DS Exercises -- Data Transformation Exercises ##

install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

knitr::opts_chunk$set(echo = TRUE)
head(flights)


## Question 1: The following questions ask you to find flights that meet certain
## criteria and then count them. How many flights flew into LAX? How many
## flights flew out of LAX? How many flights are greater than or equal to 2000
## miles? How many flights were destined for airports in the Los Angeles area
## (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

## A) 
nrow(flights %>% 
       filter(dest == "LAX"))

# Answer : 16,174 flights

## B)
nrow(flights %>% 
       filter(origin == "LAX"))

# Answer: 0 >>> Because these are NYC flights!!!!!!!

## C)
nrow(flights %>% 
       filter(distance >= 2000))

# Answer: 51,695 flights     

## D)
nrow(flights %>%
       filter(origin != "JFK") %>% 
       filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")))

# Answer: 5737 flights


## Question 2: How many flights were "ghost flights"? A "ghost flight" is
## defined as a flight that departed, but never arrived (i.e., has a missing
## arr_time).

nrow(flights %>% 
  filter(is.na(arr_time)) %>% 
  filter(is.finite(dep_time)))

# Answer: 458 ghost flights

## Question 3: How does arrange() treat missing values? How could you sort all
## rows with a missing arr_time to the top of the dataset?

# Answer: arrange() just changes the order of a data table, literally sorting it
# into whatever you call. The code below puts all the flights with blank arrival
# times of NA at the top.

# Code Answer: 

flights %>% 
  arrange(desc(is.na(arr_time)))


## Question 4: What do you observe after running the code below? How does this
## behavior reflect how select() helpers deal with uppercase and lowercase
## matching by default? How can you change that default?

select(flights, contains("TIME"))

# A) Answer: The code above does not run, because there is an unexpected answer!
# I think it is the symbol at the end of the code, after the parentheses.

# B) Answer: The select() statement does not know how to deal with case - as
# seen when the code is run. If I take off the last part, also, it runs, giving
# me a chart, but also giving me a warning message with this: In
# as.POSIXlt.POSIXct(x, tz) :unknown timezone
# 'zone/tz/2018c.1.0/zoneinfo/America/New_York'

# C) Answer: I think you add an empty string to the select list, as seen on
# stackoverflow


## Question 5: For each destination greater than or equal to 2000 miles away,
## compute total minutes of departure delay. Then determine what proportion of
## total-departure-delay minutes each destination represents. What three
## destinations top the list?

flights %>% 
      filter(distance >= 2000) %>% 
      filter(dep_delay > 0) %>% 
      group_by(dest) %>% 
      summarize(
        total_delay = sum(dep_delay, na.rm = TRUE)) %>% 
      mutate(
        proportional_delay = (total_delay/(sum(total_delay))
      )) %>% 
      arrange(desc(proportional_delay))

# Answer: Top 3 Destinations: SFO, LAX, LAS
# Answer: SFO = 0.296, LAX = 0.278, LAS = 0.105













