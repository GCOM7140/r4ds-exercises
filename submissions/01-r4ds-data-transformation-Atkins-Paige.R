#install.packages ("tidyverse")
#install.packages ("nycflights13")
library(nycflights13)
library(tidyverse)

#Q1:
?flights
filter(flights, dest== "LAX")
#16,174

filter(flights, origin== "LAX")
#0??

filter(flights, distance>= "2000")
#220,021

filter(flights, origin!="JFK", dest %in% c ("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"))
#5,737

#Q2:
filter(flights, is.na(arr_time))
#8,713

#Q3:
?arrange
arrange(flights, !is.na(arr_time), arr_time)

#Q4:
select(flights, contains("TIME"))
#???? 
#change to...
select(flights, contains("TIME", ignore.case = FALSE))

#Q5
filter(flights, distance>= "2000", dep_delay> "0") %>%
group_by(dest) %>%
summarize(total_dep_delay = sum(dep_delay)) %>%
mutate(prop=total_dep_delay/sum(total_dep_delay)) %>%
arrange(desc(prop)

