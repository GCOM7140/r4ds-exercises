install.packages("nycflights13")
library(tidyverse)
library(nycflights13)
#Question 1
flights %>%
  filter(dest == "LAX") %>%
  nrow()

flights %>%
  filter(origin == "LAX") %>%
  nrow()

flights %>%
  filter(distance >= "2000") %>%
  nrow()

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

#Question 2
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

#Question 3
#Arrange will first sort existing values either in ascending or descending order, then will display missing values
flights %>% 
  arrange(desc(is.na(arr_time)))

#Question 4
select(flights, contains("TIME"))
#The code didn't select any columns because contains is case sensitive
select(flights, contains("TIME", ignore.case = TRUE))

#Question 5
flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

