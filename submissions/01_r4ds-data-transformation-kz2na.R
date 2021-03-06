library(tidyverse)
library(nycflights13)

#Question 1: Responding to this set of questions requires two steps: (a) finding flights that meet certain criteria and (b) counting these subsets of flights.

#view(flights)

## How many flights flew into LAX?

# Method 1:
count(filter(flights, dest == "LAX"))

# Method 2:
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

# Method 3:
nrow(filter(flights, dest == "LAX"))

## How many flights flew out of LAX?
nrow(filter(flights, origin == "LAX"))

## How many flights were longer than or equal to 2,000 miles in distance?
nrow(filter(flights, distance >= 2000))

## How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flights %>% filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB") & !origin == "JKF") %>% nrow()

## Comment: in the filter() function, the first component is the data frame and the others are the expressions that filter the data frame by using "=="

--- 
  #Question 2: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).
  
  flights %>% filter(!is.na(dep_time) & is.na(arr_time)) %>% nrow()

## Comment: use is.na to consider whethe a certain variable has a missing value

---
  #Question 3: How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?
  
  arrange(flights, desc(is.na(arr_time)))

---
  #Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?
  
  #select(flights, contains("TIME"))
  #Actually the function contains() is not case sensitive and has the same results with the below function.
  
  select(flights, contains("TIME", ignore.case = TRUE))

---
  #Question 5: For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?
  
  flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

## Comments: group_by(fliter(flights,...)) still has the whole data frame;summarize(group_by(fliter(flights,...))) then has only two columns, one is dest, and another is total delay minutes