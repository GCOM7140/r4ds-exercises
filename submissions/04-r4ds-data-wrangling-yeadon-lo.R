##################################################
## Project:r4ds Data Wrangling
## Script purpose: Homework submission
## Date: 17 April 2018
## Author: Lo Yeadon
##################################################

library(tidyverse)
library(nycflights13)

#Exercise 1: Why can't you spread people? How could you add a new column to people to fix the problem?

#Answer Excercise 1:
people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)


#Excercse 2:Do you need to gather or spread preg to tidy it? What variables are there in preg?

#Answer Excercise 2:
preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")


#Excercise 3: How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

  #tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
    #separate(x, c("one", "two", "three"))

#Answer Excercise 3:
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')


#Excercise 4:Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

#Answer Excercise 4:
#The remove argument determines whether R should remove or keep the original column being parsed. The default is to remove the column(s); however, it might make sense to keep the original column(s) for troubleshooting purposes or another operation.

#Excercise 5: Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?

#Answer 5:
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


#Excercse 6: At what gust speeds are departure delays out of NYC the longest on average?

#Answer 6:
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
