# Yujing (Jenny) Zhao
# r4ds-exercise

#install.packages("nycflights13")
library(tidyverse)
library(nycflights13)

# Question 1
flights %>%
  filter(dest == 'LAX') %>%
  nrow()

flights %>%
  filter(origin = "LAX") %>%
  nrow()

flights %>%
  filter(distance >= 2000) %>%
  nrow()

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

# Question 2
flights %>% 
  filter(is.na(arr_time), !is.na(dep_time)) %>% 
  nrow()

# Question 3
flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))

# Question 4
flights %>%
  select(flights, contains("TIME", ignore.case = TRUE))

# Question 5
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)

