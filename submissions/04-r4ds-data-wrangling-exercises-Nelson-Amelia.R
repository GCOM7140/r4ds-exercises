#' --- 
#' title: "r4ds exercise 4" 
#' author: Amelia Nelson
#' date: April 17, 2018 
#' output: github_document 
#' ---

library(tidyverse)
library(nycflights13)

# Exercise 1
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

# You can't spread people because there are two values for Ousmane's age (23 and 33) and R does not know which one to use. To fix this problem, we can add another column that specifies row number (representing time) to distinguish age at different times so you can have more than one value applicable for age. 

people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)

# Exercise 2
# Do you need to gather or spread preg to tidy it? What variables are there in preg?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

# You need to gather, not spread, because some of the values for these columnds are values of variables, not just names of variables. 

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

# Exercise 3
# How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

# The warning message indicates that there is an extra, unexpected item in row 2. This is because the code only specified 3 columnds, but the second row has 4 items. To fix, set the extra argumenet to merge. 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')

# Exercise 4 
# Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

# When remove = TRUE, the function will remove the input column from the output data frame. It might make sense to set remove = FALSE when you want to manipulate duplicates in the new column for analysis purposes. 

# Exercise 5
# Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  group_by(country, year) %>% 
  summarise(cases = sum(value)) %>% 
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  ggplot(aes(x = year, y = cases, color = country)) +
  geom_point() +
  geom_line()

# India has an unusual jump of cases of TB in the year 2007 that immediately reverts to normal the next year. Number of TB cases is generally a lot lower in Bangladesh than in nearby countries of China and India. There is a large jump in TB cases from 2008-2009 in China. 

# Exercise 6
# Begin by following these steps:
# 1. Join observations in flights with those in weather by origin, year, month, day, and hour.
# 2. Bin wind_gust and calculate average dep_delay for each bin.
# 3. Create a bar graph.
# At what gust speeds are departure delays out of NYC the longest on average?

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

# Departure delays are longest (around 28 minutes) when wind gusts are between 35-30 mph. 
