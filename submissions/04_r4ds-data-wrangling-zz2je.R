library(nycflights13)
library(tidyverse)

#Question 1: The player tibble below is meant to record De’Andre Hunter and Kyle Guy’s dates of birth and heights. Why can’t you tidy it up with the spread() function? How could you add a new column to player to fix the problem?

player <- tribble(
  ~name,             ~key,     ~value,
  #----------------/---------/-----------------------
  "De'Andre Hunter",    "dob", "December 2, 1997",
  "De'Andre Hunter", "height", 201,
  "De'Andre Hunter",    "dob", "August 11, 1997",
  "Kyle Guy",           "dob", "August 11, 1997",
  "Kyle Guy",        "height", 191
)

#Because De'Andre Hunter has two different dob values, and R can't process it without knowing which value to add to the dob column. 

player %>% 
  group_by(name,key) %>% 
  mutate(keep= row_number()) %>% 
  filter(keep==1) %>% 
  spread(key,value)
#  name             keep        dob           height
#1 De'Andre Hunter     1  December 2, 1997     201   
#2 Kyle Guy            1  August 11, 1997      191 


#Question 2: Do you need to gather or spread preg (see below) to tidy it? What variables does preg include?
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>% 
  gather("male","female",key="gender",value="count")
#  pregnant gender  count
# 1 yes      male      NA
# 2 no       male      20
# 3 yes      female    10
# 4 no       female    12

#Yes it needs gather to tidy female/male as values into variable gender. Thus preg has variable "pregnant", "gender" and "count"


#Question 3: How would you explain the warning message below in layman’s terms to someone who couldn’t figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#The warning message suggests that since each row only has three spots to assign values in but there are four values needed to be assigned in the second row, thus the last value "g"is discarded as a result.
#to remedy, shoud change default extra= warn into extra = merge
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"),extra = "merge")


#Question 4: Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?
#Argument remove decides whether to remove the input column (the column being parsed) from the output dataframe. The default is True but for code-review or troubleshooting purpose, it also makes sense to set it as FALSE.


#Question 5: Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  group_by(country, year) %>% 
  filter(country %in% c("China", "India", "Bangladesh")) %>% 
  summarise(total_number_of_cases = sum(value)) %>% 
  ggplot(aes(x = year, y = total_number_of_cases, colour = country))+
  geom_line()

#India has an unusually high number of cases of TB in 2007, which could be an error in the data. 


#Question 6: At what wind speeds are departure delays out of NYC the longest on average?
flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(wind_speed_cat = cut_width(wind_speed, width = 6, center = 3)) %>% 
  group_by(wind_speed_cat) %>% 
  summarise(mean_dep_delay =mean(dep_delay, na.rm =TRUE)) %>% 
  arrange(desc(mean_dep_delay))
#Thus, Departure delays out of NYC are longest when wind speeds are between 30 and 36 mph on average.  

