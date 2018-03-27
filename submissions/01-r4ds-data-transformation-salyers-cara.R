library(tidyverse)
library(nycflights13)

########## Question 1 ##########

# How many flights flew into LAX?
LAXdest <- filter(flights, dest == "LAX")
nrow(LAXdest)
# ANSWER: 16174
  
# How many flights flew out of LAX?
LAXorigin <- filter(flights, origin == "LAX")
nrow(LAXorigin)
# ANSWER: 0
  
# How many flights are greater than or equal to 2000 miles?
mi2000 <- filter(flights, distance > 2000)
nrow(mi2000)
# ANSWER: 51695
  
# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
destLA <- filter(flights, dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), origin != "JFK")
nrow(destLA)
# ANSWER: 5737


########## Question 2 ##########

# How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived 
ghost <- filter(flights, dep_time > 0, is.na(arr_time))
nrow(ghost)
# ANSWER: 458


########## Question 3 ##########

# How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?
# ANSWER: arrange() always sorts missing values at the end, to sort them at the top:
flights %>%
  arrange(desc(is.na(arr_time)))


########## Question 4 ##########

# What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?
select(flights, contains("TIME"))
# ANSWER: the result for select() is not case sensitive because the variable names are lower-case, but still return the tibble when the code contains TIME in uppercase. To change this:
select(flights, contains("TIME", ignore.case = FALSE))


########## Question 5 ##########

# For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list?
flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarise(total.delay = sum(dep_delay)) %>%
  mutate(prop.total.delay = total.delay / sum(total.delay)) %>%
  arrange(desc(prop.total.delay)) %>%
  head(3)
# ANSWER: SFO, LAX, LAS


  







