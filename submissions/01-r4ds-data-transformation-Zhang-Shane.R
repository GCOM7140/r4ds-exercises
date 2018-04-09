install.packages('tidyverse')
install.packages('nycflights13')

library(tidyverse)
library(nycflights13)
?flights

#Q1
--------------------------------------------------------
flights %>%
  filter(dest == 'LAX')%>%
  nrow()

flights %>%
  filter(origin == 'LAX')%>%
  nrow()

flights %>%
  filter(distance >= 2000)%>%
  nrow()

flights %>%
  filter(dest %in% c('LAX','ONT','SNA','PSP','SBD','BUR','LGB'), 
         origin != 'JFK')%>%
  nrow()


#Q2
------------------------------------------------------------
flights %>%
  filter(is.na(arr_time), !is.na(dep_time)) %>%
  nrow()


#Q3
-----------------------------------------------------------
flights %>%
  arrange(desc(is.na(arr_time)), desc(arr_time))

#Q4
-----------------------------------------------------------
select(flights, contains("TIME", ignore.case = TRUE))
# The original code still runs because ignore.case = TRUE is a default setting for contains


#Q5
-------------------------------------------------------------
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(total_dep_delay_minutes = sum(dep_delay)) %>%
  mutate(delay_proportion = total_dep_delay_minutes / sum(total_dep_delay_minutes)) %>%
  arrange(desc(delay_proportion)) %>%
  head(3)


