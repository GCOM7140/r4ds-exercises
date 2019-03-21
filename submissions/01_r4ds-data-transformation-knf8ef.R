#####################################
### GCOM 7140 (Customer) ############
### Data Transformation Exercises ###
### R4DS, Chapter 5               ###
### 3/21/19                       ###
#####################################


### file name: 01_r4ds-data-transformation-knf8ef.R


library(tidyverse)
library(nycflights13)


### Question 1: Responding to this set of questions requires two steps: (a) finding flights that meet certain criteria and (b) counting these subsets of flights.

## a. How many flights flew into LAX?
nrow(filter(flights, dest == "LAX"))

## b. How many flights flew out of LAX?
nrow(filter(flights, origin == "LAX"))

## c. How many flights were longer than or equal to 2,000 miles in distance?
nrow(filter(flights, distance >= 2000))

## d. How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
LA_dest <- c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")
nrow(filter(flights, dest %in% LA_dest & origin != "JFK"))


### Question 2: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).

nrow(filter(flights, is.na(dep_time) == FALSE & is.na(arr_time) == TRUE))


### Question 3: How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?

# The "arrange()" function always places missing values at the end of the data.

arrange(flights, desc(is.na(arr_time)))


### Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?
select(flights, contains("TIME"))

# The code narrows down the datset by using only columns with the word "time" in their name. This reflects that "select()" helpers are case insensitive by default. You can override the default by changing the argument value for "ignore.case" to TRUE or FALSE.

# The solution for this problem says the opposite, however the default value for "ignore.case" is "TRUE" (see help file)
?dplyr::contains


### Question 5: For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

part_filter <- filter(flights, distance >= 2000, arr_delay > 0)
part_group <- group_by(part_filter, dest)
part_summarize <- summarize(part_group, total_arr_delay = sum(arr_delay))
part_mutate <- mutate(part_summarize, prop_arr_delay = total_arr_delay / sum(total_arr_delay))
head(arrange(part_mutate, desc(prop_arr_delay)), 3)

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(total_arr_delay = sum(arr_delay)) %>%
  mutate(prop_arr_delay = total_arr_delay / sum(total_arr_delay)) %>%
  arrange(desc(prop_arr_delay)) %>%
  head(3)
