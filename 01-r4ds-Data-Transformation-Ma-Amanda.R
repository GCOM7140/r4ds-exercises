library(tidyverse)
library(nycflights13)
#How many flights flew into LAX?

flights %>%
  filter (dest == "LAX")
  nrow()

  #How many flights flew out LAX?
  
  flights %>%
    filter (origin == "LAX")
  nrow()
  
nrow(filter(flights, des == "LAX"))