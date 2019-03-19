library(tidyverse)
library(nycflights13)

nrow(filter(flights ,dest == "LAX"))

# OR

flights %>%
  filter(dest == "LAX") %>%
  nrow()
