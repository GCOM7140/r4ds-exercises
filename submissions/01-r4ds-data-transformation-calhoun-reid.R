#Reid M. Calhoun
#Customer Analytics Homework
#Due March 27, 2018 @ 11:59 PM

#################
# R4DS Exercise #
#################

library(tidyverse)
library(nycflights13)
?flights

###############
# Question 1: #
###############

#The following questions ask you to find flights that meet certain criteria and then count them

#How many flights flew into LAX?

nrow(filter(flights, dest == "LAX"))  #16174


#How many flights flew out of LAX?

nrow(filter(flights, origin == "LAX")) # 0


#How many flights are greater than or equal to 2000 miles?

nrow(filter(flights, distance >= 2000))   #51695


#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

nrow(filter(flights, dest %in% c("LAX", "ONT","SNA","PSP","SBD","BUR","LGB") & 
              origin != "JFK" ))  #5737


###############
# Question 2: #
###############

#How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing arr_time).

nrow(filter(flights, dep_time >= 0 & is.na(arr_time))) # 458


###############
# Question 3: #
###############

# How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?

arrange(flights, desc(is.na(arr_time)))
#Missing values are sent to the bottom of the data frame, regardless of descending or not

###############
# Question 4: #
###############


#What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?

select(flights, contains("time"))
#extraneous quotation mark prevents completion of code, all caps TIME does not work, while time does work. Case is important in the select function. This can be changed by using the tolower function on everything


###############
# Question 5: #
###############

#For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list?

filter(flights, distance >= 2000 & dep_delay > 0) %>% 
  group_by(dest) %>% 
  summarize(total_dep_delay= sum(dep_delay, na.rm = TRUE)) %>% 
  mutate(proportion = total_dep_delay/sum(total_dep_delay)) %>% 
  arrange(desc(proportion))

#SFO, LAX, and LAS are the top three destinations on the list

