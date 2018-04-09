

install.packages("nycflights13")
install.packages("tidyverse")

library(tidyverse)
library(nycflights13)
library(dplyr)

#Q1


filter(flights, dest == "LAX")
# Flights going to LA = 16,174

filter(flights, origin == "LAX")
#Flights leaving from LA = 0 (Not contained in Data Set)

filter(flights, distance >= 2000)
#Flights with distance more than 2000 = 51,695

filter(flights, dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), origin != "JFK" )
# There were 5,737 flights


#Q2

filter(flights, !is.na(dep_time) & is.na(arr_time))
# 458 ghost flights

#Q3
flights %>%
arrange(desc(is.na(arr_time)))

#Q4

select(flights, contains("TIME", ignore.case = FALSE))

# Just include ignore.case as one of the parameters to change in the "contains" function.


#Q5

flights %>%
  filter(distance >= 2000 & dep_delay != 0) %>%
  group_by(dest) %>%
  summarize(Total_Delay_Dest = sum(dep_delay)) %>%
  mutate(Percentage_Delay = (Total_Delay_Dest/sum(Total_Delay_Dest))) %>%
  arrange(desc(Percentage_Delay)) %>%
  head(n=3L)
