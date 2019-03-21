library(tidyverse)
library(nycflights13)

# Q1 - How many flights flew into LAX?

flights %>%
  filter(dest == "LAX") %>%
  nrow()

# Q1 - How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()

# Q1 - How many flights were longer than or equal to 2,000 miles in distance?

flights %>%
  filter(distance >= 2000) %>%
  nrow()

# Q1 - How many flights were destined for airports in the Los Angeles area (LAX,
# ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB") 
    & origin != "JFK") %>%
  nrow()


# Q2 - How many flights were "ghost flights"? A "ghost flight" is defined as a
# flight that departed, but never arrived.

flights %>%
  filter(is.na(arr_time) & !is.na(dep_time)) %>%
  nrow()


# Q3 - How does arrange() treat missing values, and how could you sort all of
# the rows with a missing arr_time to the top of the dataset?

# The missing values are either put at the very top or the very bottom. To bring
# them to the top of the dataset, they should be arranged in descending fashion
# like this:

flights %>%
  arrange(desc(is.na(arr_time)))


# Q4 - What do you observe after running the code below? How does this behavior
# reflect how select() helpers deal with uppercase and lowercase matching by
# default? How can you override this default behavior?

select(flights, contains("TIME"))

# The function contains() is supposed to be case sensitive and not return any
# columns if everything is uppercase. However, the above line of code and the
# line of code below seemed to produce the same result for same reason. Has the
# default function changed?

select(flights, contains("TIME", ignore.case = TRUE))


# Q5 - For each destination more than or equal to 2,000 miles away from NYC's
# airports, compute the total number of minutes their arrivals were delayed.
# Then, determine how much, as a percentage, each of these destinations
# contributed to the total number of arrival-delay minutes that long-haul
# destinations (i.e., those more than or equal to 2,000 miles away from NYC's
# airports) amassed in 2013. Which three destinations top the list?

flights %>%
  filter(distance >= 2000 & arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)