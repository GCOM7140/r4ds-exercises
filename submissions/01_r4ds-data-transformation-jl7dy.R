library(tidyverse)
library(nycflights13)


# How many flights flew into LAX?

flights %>%
  filter(dest == "LAX") %>%
  nrow()

# How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()
# How does arrange () treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?
?arrange 

flights %>%
  arrange((is.na(arr_time)))
#NA values get sorted either to the top of bottom. Adding the desc() function brings them to the top of the dataset.

# What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?
select(flights, contains("TIME"))
#case sensitive
select(flights, contains("TIME", ignore.case = TRUE))

## For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

flights %>% 
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct)) %>%
  head(3)


