# Author:  John Anderson
# Date: March 20, 2019
# Assignment: R4DS Exercises

library(tidyverse)
library(nycflights13)

# Question 1

# 1a) How many flights flew into LAX?

flights %>%
    filter(dest == "LAX") %>%
    nrow()

# 1b) How man flights flew out of LAX?

flights %>%
    filter(origin == "LAX") %>%
    nrow()

# 1c) How many flights were longer than or equal to 2000 miles in distance?

flights %>%
    filter(distance >= 2000) %>%
    nrow()

# 1d) How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"),
    origin != "JFK"
  ) %>%
  nrow()

# Question 2

# How many flights were ghost flights

flights %>%
  filter(
    !is.na(dep_time),
    is.na(arr_time)
  ) %>%
  nrow()

# Question 3

# How does arrange() treat missing values and how can you sort all of the rows wil missing arr_time to the top of the data set?

# It seems that arrange() will sort in either descending or ascending order depending on what you tell it to do. It would probably put the NA values last if you sort by arr_time. Since this is the case we need to tell it to sort by NA in descending order so that it puts those at the top

flights %>%
  arrange(desc(is.na(arr_time)))

# Question 4

# What do you obersve when running this code? How does this reflect how select() helps deal with upper and lowercase matching? How can you override this default?

select(flights, contains("TIME"))

# I observe the flights data frame, but only the columns that contain Time in their name.
# Select seems to ignore upper and lower case values and just finds the instances in column names where"time" in any form appears
# You can override this by adding in ignore.case = FALSE

# Question 5

# Compute total delay minutes for flights more than or equal to 2000 miles from NYC. Then determine the % of these delays that is attributed to each destination

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarise(total_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_perent_of_total = total_delay_mins /  sum(total_delay_mins)) %>%
  arrange(desc(total_delay_mins)) %>%
  head(3)
  




