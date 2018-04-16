#' ---
#' title: "R4DS Exercise #4"
#' author: Dominic Sfreddo
#' date: April 15, 2018
#' output: github_document
#' ---

library(tidyverse)
library(nycflights13)

?flights
?who

#Exercise 1

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

#This can't be spread because there are two values for Ousmane's age, so there is a conflict there.

people %>% 
  group_by(name, key) %>% 
  mutate(time = row_number()) %>% 
  spread(key, value)

#Exercise 2

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>% 
  gather('male', 'female', key = 'Gender', value = 'Responses')

#You need to gather the data to tidy it. There are 3 variables in this data set.

#Exercise 3

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#There were expected to be three characters in each row, however there were 4 in row 2 so one character was discarded. The extra argument must be changed from its default to remedy this.

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')

#Exercise 4

?separate
?unite

#Remove argument will remove input columns from the data frame output. The input column should only be kept if it will be helpful for understanding or troubleshooting later down the road.

#Exercise 5

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  group_by(country, year) %>% 
  summarise(cases = sum(value)) %>% 
  ggplot(aes(year, cases, color = country)) + 
  geom_line()

#I'm surprised to see that China is higher in recent years than India.

#Exercise 6

flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>% 
  mutate(wind_gust_bin   = cut(wind_gust, breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))) %>% 
  group_by(wind_gust_bin) %>% 
  summarise(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(aes(wind_gust_bin, avg_dep_delay)) +
  geom_col()

#Wind speeds of 35 to 40 mph lead to the longest departure delays on average.