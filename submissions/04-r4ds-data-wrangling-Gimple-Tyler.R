# Starter file for HW 4
#Question 1
library(tidyverse)
people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

people <- people %>% 
  group_by(name, key) %>% 
  mutate(obs = row_number())

people %>% 
  spread(key, value)
