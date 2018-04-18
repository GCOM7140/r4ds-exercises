####### Rosemary O'Hagan ###########    
####### Customer Analytics HW #4 ###
####### 4/17/18 ####################

library(tidyverse)
library(nycflights13)

################################################################################
################################################################################
# Question 1. Why can't you spread people? How could you add a new column to people to fix the problem? Hint: You can use group_by() and row_number() to create a time column that uniquely identifies time periods in people. This time column will fix the problem.

people <- tribble(
~name,            ~key,     ~value,
#---------------/---------/--------
"Ousmane Diaby",    "age",      23,
"Ousmane Diaby", "height",     196,
"Ousmane Diaby",    "age",      33,
"Rich Eldh",        "age",      23,
"Rich Eldh",     "height",     195
)

people %>% 
  spread(key, value)
## Error: Duplicate identifiers for rows (1, 3)

# You can't spread people because they are 2 values for Ousmane's age, but you can create two columns for separate times by adding an id number. 

people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)

################################################################################
################################################################################
# Question 2. Do you need to gather or spread preg to tidy it? What variables are there in preg?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

# This needs to gathered because there are values that are variable names.

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

################################################################################
################################################################################
# Question 3. How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

## Warning: Expected 3 pieces. Additional pieces discarded in 1 rows [2].

## # A tibble: 3 x 3
##   one   two   three
##   <chr> <chr> <chr>
## 1 a     b     c    
## 2 d     e     f    
## 3 h     i     j

# There must have been an extra value that got dropped because of the default setting for extra values set as warn. You can change this setting to merge instead. 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')


################################################################################
################################################################################
# Question 4. Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

# The remove setting has a default of TRUE which removes the input column(s) from output data frame. You can set it to FALSE if needed to troubleshoot or other operations.


################################################################################
################################################################################
# Question 5. Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? Hint: Build on this code, which tidies who:
  
  who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  group_by(country, year) %>% 
  summarise(cases = sum(value)) %>% 
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  ggplot(aes(x = year, y = cases, colour = country)) +
  geom_point() + geom_line()

# India had a crazy spike in cases around 2007!! What happened there? 


################################################################################
################################################################################
# Question 6. Begin by following these steps: 1) Join observations in flights with those in weather by origin, year, month, day, and hour. 2) Bin wind_gust and calculate average dep_delay for each bin. 3) Create a bar graph. At what gust speeds are departure delays out of NYC the longest on average?

flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(
    wind_gust_binned   = cut(wind_gust, 
                             breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))
  ) %>%
  group_by(wind_gust_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_binned, y = dep_delay)) +
  geom_col()

# Delays are longest for gusts of 35,40.