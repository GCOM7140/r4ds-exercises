library(nycflights13)
library(tidyverse)

# Question 1

# How many flights flew into LAX?

nrow(filter(flights, dest == "LAX"))

flights %>%
  filter(dest == "LAX") %>%
  nrow()

# How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()

# How many flights were longer than or equal to 2,000 miles in distance?

nrow(filter(flights, distance >= "2000"))

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(dest == "LAX" | dest == "ONT" | dest == "SNA" | dest == "PSP" | dest == "SBD" | dest == "BUR" | dest == "LGB") %>%
  filter(origin != "JFK") %>%
  nrow()

# Question 2

# How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).

flights %>%
  filter(dep_time >= 0) %>%
  filter(is.na(arr_time)) %>%
  nrow()

# Question 3

# How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?

# Arrange sorts values in ascending order with NA's at the beginning

arrange(flights, desc(is.na(arr_time)))

# Question 4

# What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?

select(flights, contains("TIME"))

# contains is not case sensitive, so all columns are selected with "time" in any case

# Question 5

# For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

arr_delay_by_dest <- filter(flights, distance >= 2000 & arr_delay> 0 )[c("dest","arr_delay")] %>%
  group_by(dest) %>%
  summarize(sum(arr_delay))

arr_delay_by_dest["proportion"] <- arr_delay_by_dest[2]/sum(arr_delay_by_dest[2])
arr_delay_by_dest["proportion"]

head(arrange(arr_delay_by_dest, desc(proportion)))[1:3,]


