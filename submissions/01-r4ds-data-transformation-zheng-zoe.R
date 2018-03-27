library(tidyverse)
library(nycflights13)
library(dplyr)
?flights


#question 1
#How many flights flew into LAX?
filter(flights,dest=="LAX")%>%
nrow()
 
#How many flights flew out of LAX?
filter(flights,origin=="LAX")%>%
  nrow()
#How many flights are greater than or equal to 2000 miles?
filter(flights,distance>2000)%>%
  nrow()

#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
filter(flights,dest%in%c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR",  "LGB"))%>%
  nrow()


#question 2
filter(flights,is.na(arr_time))%>%
  nrow()


#question 3
arrange(flights,desc(is.na(arr_time)))

#question 4 

select(flights, contains("TIME"))
#select is not capital sensitive. To change the default, type in "ingnore.case=FALSE" in select function.

#question 5

mutate(flights,dep_delay=dep_time-sched_dep_time)%>%
  filter(dep_delay>0,distance>=2000)%>%
  group_by(dest)%>%
  summarise(total_delay=sum(dep_delay))%>%
  mutate(proportion=total_delay/sum(total_delay))%>%
  arrange(desc(proportion))%>%
  head(3)



