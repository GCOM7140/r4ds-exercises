library(tidyverse)
library(nycflights13)

# How many flights flew into LAX?
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()