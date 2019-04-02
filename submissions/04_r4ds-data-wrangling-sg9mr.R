title: "Data Wrangling Solutions"
output: github_document
---
  

library(nycflights13)
library(tidyverse)

*Question 1*: The `player` tibble below is meant to record DeAndre Hunter and Kyle Guys dates of birth and heights

#Why can't you tidy it up with the [`spread()`][12.3.2] function? 
#How could you add a new column to `player` to fix the problem?

# Spreading the `player` tibble fails because there are two different observations for De'Andre's date of birth. R doesn't know which observation you'd prefer to keep, so it throws an error 

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

*Question 2*: Do you need to [gather][12.3.1] or [spread][12.3.2] `preg`to tidy it? What variables does `preg` include?
  
  #`preg` needs to be gathered because it has values as variable names. The variables in `preg` are `pregnant`, `gender`, and `count`.
  
  preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")
  
*Question 3*: How would you explain the warning message below in laymans terms to someone who couldnt figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the [`separate()`][12.4.1] function call. What could they do to remedy the situation?
  
  tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

*Question 4*
# The `remove` argument determines whether R should remove or keep the original column(s) being parsed. The default is to remove the column(s); however, it might make sense to keep the original column(s) for troubleshooting purposes or another operation in certain situations.

*Question 5*
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

# The extremely low number of cases in Bangladesh in 2009 might surprise you. It is likely an error in the data. For China, the dramatic increase from 2008 to 2009 is surprising. For India, 2007 is definitely something worth looking into.

*Question 6*
  flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(
    wind_speed_binned = cut_width(wind_speed, width = 5, center = 2.5)
  ) %>%
  group_by(wind_speed_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_speed_binned, y = dep_delay)) +
  geom_col()
flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  ggplot(aes(x = wind_speed, y = dep_delay)) +
  geom_smooth()

# Departure delays are longest when wind speeds are between 30 and 35 mph.
