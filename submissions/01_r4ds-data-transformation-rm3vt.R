library(tidyverse)
install.packages("nycflights13")
library(nycflights13)

# Question 1
# How many flights flew into LAX?
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

# How many flights flew out of LAX?
flights %>% 
  filter(origin == "LAX") %>% 
  nrow()

# How many flights were longer than or equal to 2,000 miles in distance?
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, 
# SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

# Question 2: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

# Question 3: How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?
flights %>% 
  arrange(desc(is.na(arr_time)))
# arrange() treats missing values by adding them to the end so to sort them at the top of the data base, you would have to make the list descending 

# Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?
select(flights, contains("TIME"))
# The code above did nothing because contains() is case sensitive. The following code should fix this: 
select(flights, contains("TIME", ignore.case = TRUE))

# Question 5: For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?
flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

