library(tidyverse)
library(nycflights13)

# 1a) How many flights flew into LAX?

flights %>% 
  filter(dest == "LAX") %>% 
  nrow()

