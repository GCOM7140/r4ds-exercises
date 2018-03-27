library(tidyverse)
library(nycflights13)
?flights

#Question 1 

flights %>%
filter(dest == 'LAX')%>%
nrow()

flights %>%
filter(origin == 'LAX')%>%
nrow()

flights %>%
filter(distance >= 2000)%>%
nrow()
