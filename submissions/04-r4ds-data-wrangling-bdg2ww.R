library(nycflights13)
library(tidyverse)

# Question 1: The player tibble below is meant to record De’Andre Hunter and Kyle Guy’s dates of birth and heights. Why can’t you tidy it up with the spread() function? How could you add a new column to player to fix the problem?

# spread() can't be used because one observation is scattered across multiple columns 
# Resolve it with a new column. Not exactly sure how, but the solution guide says as follows:

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

# Question 2: Do you need to gather or spread preg (see below) to tidy it? What variables does preg include?



