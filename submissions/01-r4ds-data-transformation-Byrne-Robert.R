install.packages("tidyverse")
install.packages("nycflights13")
library(tidyverse)
library(nycflights13)


####### R4DS questions 
#### question 1 
?flights

head(flights)

filter(flights, dest== "LAX")

# 16174 flights a year go from NY to LAX

filter(flights, origin== "LAX")

# this shows 0 flights -- look into this, probably wrong 

filter(flights, distance >= "2000")

# 220,021 

filter(flights, origin != "JFK", dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")) 

#5737

### Question 2 
filter(flights,is.na(arr_time))
#8713 


###Question 3 
arrange(flights, !is.na(arr_time))


### Question 4 
select(flights, contains("TIME"))
select(flights, contains("TIME", ignore.case = FALSE) )

# We need to add the ignore case funtion 
# I am only seing '+' and then my code after I run these functions, not sure what is going on 

### Question 5 

flights %>% 
  filter(distance >= 2000) %>% 
  filter(dep_delay > 0) %>% 
  group_by(dest) %>% 
  summarize(
    total_delay = sum(dep_delay, na.rm = TRUE)) %>% 
  mutate(
    proportional_delay = (total_delay/(sum(total_delay))
    )) %>% 
  arrange(desc(proportional_delay))


