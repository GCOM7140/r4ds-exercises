# R4DS - Exercise 4 - Data Wrangling
  # Christian Mitchell

library(tidyverse)
library(nycflights13)

# Problem 1

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
  spread(key, value) # Can't use spread because age for Ousmane is repeated

people %>% 
  group_by(name, key) %>%
  mutate(id = row_number()) %>% 
  spread(key, value)

# Problem 2

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
# Yes, need to gather to turn male and female into keys and female into a value

preg %>% 
  gather("male", "female", key = "gender", value = "count")

# Problem 3

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))
  # the tibble has a 4th letter in the second observation, and the following code remedies this:

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')

# Problem 4

# Both  [`separate()`][G&W 2017, 12.4.1]  and [`unite()`][G&W 2017, 12.4.2] have a
# `remove` argument. What does it do? When does setting it to `FALSE` make sense?

# This removes an input column from an output data frame, per the help page on the function. Setting to false makes sense if you plan to continue using the columns that would otherwise be removed.

# Problem 5

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  group_by(country, year) %>% 
  summarize(total_cases = sum(value)) %>% 
  filter(country %in% c("China", "India", "Bangladesh")) %>% 
  ggplot(aes(year, total_cases, color = country)) +
  geom_point() +
  geom_line()

# Problem 6

flights %>% 
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>% 
  mutate(
    wind_gust_binned   = cut(wind_gust, 
                             breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))
  ) %>% 
    group_by(wind_gust_binned) %>% 
    summarize(delay = mean(dep_delay, na.rm = TRUE)) %>% 
    ggplot(aes(wind_gust_binned, delay)) +
    geom_col()

# Flight delays are highest when wind gusts are between 35 and 40 mph  
  