####### Rosemary O'Hagan ###########
####### Customer Analytics HW #1 ###
####### 3/27/18 ####################

######################################################
##### R4DS Questions #################################
######################################################

library(tidyverse)
library(nycflights13)
?flights

##### Question 1 ###############################################################
# How many flights flew into LAX?

into_lax <- filter(flights, dest == "LAX") 
nrow(into_lax) #16,174

# How many flights flew out of LAX?

outLAX <- filter(flights, origin == "LAX")
nrow(outLAX) #0

# How many flights are greater than or equal to 2000 miles?

flights2000 <- filter(flights, distance >= 2000)
nrow(flights2000) #51,695

# How many flights destined for airports in LA area but not from JFK?

toLAnotfromNYC <- filter(flights, 
                         dest %in% c("LAX", "ONT", "SNA", "PSP", 
                                     "SBD", "BUR", "LGB") 
                         & !(origin == "JFK"))
nrow(toLAnotfromNYC) #5,737

##### Question 2 ###############################################################
# How many flights were "ghost flights"?

ghostflights <- filter(flights, is.na(arr_time))
nrow(ghostflights) #8,713

##### Question 3 ###############################################################
# How does arrange() treat missing values? How could you sort all the rows with 
# a missing arr_time to the top of the dataset?

# arrange() always sorts missing values at the end... 
arrange(flights, desc(is.na(arr_time)))

##### Question 4 ###############################################################
# What do you observe after running the code below? How does this behavior 
# reflect how select() helpers deal with uppercase and lowercase matching by 
# default? How can you change that default?

select(flights, contains("TIME"))
# select() is not case sensitive by default 
?select # change default setting of ignore.case from TRUE to FALSE
select(flights, contains("TIME", ignore.case = FALSE)) # no tibble

##### Question 5 ###############################################################
# For each destination greater than or equal to 2000 miles away, compute total 
# minutes of delay. Also determine what proportion of these total minutes of 
# delay the destinations represent. What are the top-three destinations by 
# proportion of total, and what proportions do each of the top-three 
# destinations represent?

flights %>% 
  filter(distance >= 2000, dep_delay> 0) %>%
  group_by(dest) %>%
  summarize(total_dep_delay = sum(dep_delay)) %>%
  mutate(prop = total_dep_delay / sum(total_dep_delay)) %>%
  arrange(desc(prop))