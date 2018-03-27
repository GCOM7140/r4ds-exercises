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
#   