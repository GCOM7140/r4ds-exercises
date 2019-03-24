library(tidyverse)
library(nycflights13)

# Q1
# How many flights flew into LAX?  16174

flights

nrow(filter(flights, dest == "LAX"))

flights %>%
  filter(dest == "LAX") %>%
  nrow()
  
# How many flights flew out of LAX?  0
  
  flights %>%
    filter(origin == "LAX") %>%
    nrow()
  
#How many flights were longer than or equal to 2,000 miles in distance? 51695
  flights %>%
    filter(distance >= 2000) %>%
    nrow()
  
  
#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK? 18057
  flights %>%
    filter(dest %in% c("LAX","ONT","SNA","PSP","SBD","BUR","LGB") )%>%
    filter(origin != "JKF") %>%
    nrow()
  
  
#Question 2: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).  458
  
  flights %>%
    filter(!is.na(dep_time)) %>%
    filter(is.na(arr_time)) %>%
    nrow()
  
# Question 3: How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?

  flights %>%
    arrange(desc(is.na(arr_time)))

# Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?
  
   select(flights, contains("TIME"))
   # select function is not sensitive to lowercase or uppercase.
   select(flights, contains("TIME", ignore.case = FALSE)) # A tibble: 336,776 x 0

   
#Question 5: For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

flightnyc <- (flights %>% 
     filter(origin %in% c("LGA","JFK","EWR")) %>%
     filter(distance >= 2000)%>%
     filter(arr_delay > 0))
flightnyc

 sum(flightnyc$arr_delay) # 705693
 
 
# 2013 nyu airports total delay 
 flightnyc2013 <- (flights %>% 
                 filter(year == "2013")%>%
                 filter(origin %in% c("LGA","JFK","EWR")) %>%
                 filter(distance >= 2000)%>%
                 filter(arr_delay > 0))
 flightnyc2013
 sum(flightnyc2013$arr_delay) 
 
 # LGA
flightlga <- (flights %>%
             filter(year == "2013")%>%
             filter(origin == "LGA")%>%
             filter(distance >= 2000)%>%
             filter(arr_delay > 0))

sum(flightlga$arr_delay) # =0, LGA airport accounts for 0% of delay.

#JFK
flightjfk <- (flights %>%
                filter(year == "2013")%>%
                filter(origin == "JFK")%>%
                filter(distance >= 2000)%>%
                filter(arr_delay > 0))

sum(flightjfk$arr_delay) #439284
percentagejfk = sum(flightjfk$arr_delay)/sum(flightnyc2013$arr_delay)
percentagejfk # 0.622486 JFK airport accounts for about 62.25% of delay.

#EWR
percentageewr = 1- percentagejfk
percentageewr # 0.377514 EWR airport accounts for about 37.75% of delay.

 
