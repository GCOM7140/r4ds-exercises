#' -----------
#' Title:   R4DS Exercise 4 
#' Author:  Lani Hannah 
#' Date:    April 17, 2018
#' -----------

#' load libraries
library(tidyverse)
library(nycflights13)

#' Question 1: Why can't you spread people? How could you add a new column to people to fix the problem? You can't spread people because there are two different age  values in rows 1 & 3. We can add a time column to fix the problem. 

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
  group_by(name, key) %>% 
  mutate(time = row_number()) %>% 
  spread(key, value)

#' Question 2: Do you need to gather or spread preg to tidy it? What variables are there in preg? Use gather because you need to specify whether the values refers to males or  females. The variables are pregnant, gender, and count. 

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>% 
  gather('male', 'female', key = "gender", value = "count")

#' Question 3: How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?
#' The letter 'g' was discarded in the second row because only 3 columns were specified. You could add a new column, but you won't have any letters to populate  rows 1 and 3. You could use the 'merge' and 'fill' arguments to put 'g' in the same place (row and column) as 'f'. 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge", fill = "right")

#' Question 4: Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?
#' It removes the input column from the output data frame. You may want to set it to false to see before and after results perhaps. 


#' Question 5: Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?
#' The high spike in the number of cases in India around 2007 and the low (looks like zero) number of cases in Bangladesh in 2009. 
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
  geom_point() +
  geom_line()

#' Question 6: Begin by following these steps: 
#' 1. Join observations in flights with those in weather by origin, year, month,    day, and hour.
#' 2. Bin wind_gust and calculate average dep_delay for each bin.
#' 3. Create a bar graph.
#' At what gust speeds are departure delays out of NYC the longest on average?
flightsdf <- left_join(flights, weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>% 
  select(origin, year, month, day, hour, wind_gust, dep_delay)

flightsdf %>% 
  mutate(
    winds_binned = cut(wind_gust, 
                       breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))
  ) %>% 
  group_by(winds_binned) %>% 
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(x = winds_binned, y = dep_delay)) +
  geom_col()
  



