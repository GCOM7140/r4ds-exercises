library(tidyverse)
library(nycflights13)

# How many flights flew into LAX?

flights %>%
  filter(dest == "LAX") %>%
  nrow()

nrow(filter(flights, dest == "LAX"))

# How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()