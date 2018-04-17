#' ---
#' title: "Answers to R4DS Data Wrangling Exercises"
#' author: Luna Han
#' date: April 16, 2018
#' output: github_document 
#' --- 
library(tidyverse)
library(nycflights13)
?flights
?who

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
  group_by(name, key) %>%
  mutate (time = row_number()) %>%
  spread(key, value)

# Exercise 2

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
# It needs to be gathered.

preg %>%
  gather ('male', 'female', key = 'sex', value = 'cases' )

# Exercise 3
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))
# R returns a warning message because the second column has more than three values.
# In order to fix this, we need to change the default setting of extra value into 'merge'.
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')

# Exercise 4
tibble(x = c("a,b,c", "d,e,f", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), remove = FALSE)
# The remove argument is to remove the input column from the output data frame. When we want to keep the original data source and help others to check the results later, seeting the remove argument to FALSE would make sense.

# Exercise 5 calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time.
?who
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year) %>%
  mutate (total_cases = sum(value)) %>%
  filter (country %in% c('China', 'India', 'Bangladesh')) %>%
  ggplot ( aes(x = year, y = total_cases, color = country)) +
  geom_point() +
  geom_line()

# Exercise 6
flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour') %>%
  mutate(
    wind_gust_binned = cut(wind_gust, break = seq(0, max(wind_gust), 5))
                           ) %>%
  group_by (wind_gust_binned) %>%
  mutate (avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_binned, y = avg_delay)) +
  geom_bar()

               
