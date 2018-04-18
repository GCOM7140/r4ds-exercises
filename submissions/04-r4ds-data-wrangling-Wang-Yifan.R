knitr::opts_chunk$set(echo = TRUE, eval = TRUE, message = FALSE)
pdf(NULL)

library(tidyverse)
library(nycflights13)


# Question 1

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

# Cannot spread because R says there are duplicate identifiers for Ousmane's age.

people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)


# Question 2

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

# preg needs to be gathered because it has values as variable names, which are pregnant, gender, and count.

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")


# Question 3

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

# The warning message indicates that the second observation has an extra piece (or value), and that this extra piece (i.e., "g") was dropped.

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')


# Question 4

# The remove argument determines whether R should remove or keep the original column(s) being parsed. The default is to remove the column(s); however, it might make sense to keep the original column(s) for troubleshooting purposes or another operation.


# Question 5

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

# The extremely low number of cases in Bangladesh in 2009 surprises me. For China, the dramatic increase from 2008 to 2009 is surprising. For India, 2007 is definitely something worth looking into.


# Question 6

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

# Departure delays are longest when gust speeds are between 35 and 40 mph.