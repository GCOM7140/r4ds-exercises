install.packages("tidyverse")
install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

?flights
#question 1, how many flights flew into LAX?

flights
view(flights)
View(flights)

laxflights <- filter(flights, dest == "LAX")
laxflights
nrow(laxflights)
#16174 flights

#question 1.2
laxdep <- filter(flights, origin == "LAX")
laxdep
nrow(laxdep)
#0 flights flew out of LAX

#question 1.3

flights_2000 <- filter(flights, distance >= 2000)
nrow(flights_2000)
#51695

#questionn 1.4
notfromNY <- filter(flights, dest %in% c("LAX","ONT","SNA","PSP","SBD","BUR","LGB"), origin != "JFK")
nrow(notfromNY)
#5735 


#question 2
noarrival <- filter(flights, origin == "NYC" & is.na(flights$arr_time))
# 0 

#question 3

missing_val <- arrange(flights, desc(is.na(flights$arr_time)))

#question 4
select(flights, contains("TIME"))
?one_of
?contains
# to change the default we must changethe argument ignore.case from TRUE to FALSE 

#question 5

q5_flight <- filter(flights, distance >= 2000 & dep_delay > 0)
step2 <- group_by(q5_flight, dest)
step3 <- summarise(step2, delay = sum(dep_delay,na.rm = TRUE))
step3

sum(step3$delay)
step4 <- mutate(step3, proportion = delay/667329)
step4

step5 <- arrange(step4, desc(proportion))
step5
#SFO LAX LAS