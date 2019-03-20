library(tidyverse)
library(nycflights13)

# 1a) How many flights flew into LAX?

flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

# 1b) How many flights flew out of LAX?

flights %>% 
  filter(origin == "LAX") %>% 
  nrow()
