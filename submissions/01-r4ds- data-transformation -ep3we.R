install.packages("tidyverse")
install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

flights<-flights

#1
#flights flew into LAX
(INTOLAX <-filter(flights,dest == "LAX", .preserve=FALSE))
nrow(INTOLAX)

#flights flew out of LAX
(OUTOFLAX <-filter(flights, origin == "LAX", .preserve=FALSE))
nrow(OUTOFLAX)

#flights >= 2,000 miles
(LDistance <- filter(flights, distance>= 2000, .preserve=FALSE))
nrow(LDistance)

#Destined for LA but did not originate out of JFK
(TOLA <- filter(flights, origin != "JFK" & dest %in% c("LAX","ONT","SNA","PSP","SBD","BUR","LGB"), .preserve=FALSE))
nrow(TOLA)


#2
(ghostflight<-(filter(flights, is.na(arr_time) & dep_time >0)))
nrow(ghostflight)

#3
# arrange() leaves missing values at the end
arrange(flights, desc(is.na(arr_time)))


#4
select(flights, contains("TIME"))
#In the answer, it says that select() is case sensitive. However, the code above selects all columns that include the word "time" without using "ignore.case = TRUE". 

#5
flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

