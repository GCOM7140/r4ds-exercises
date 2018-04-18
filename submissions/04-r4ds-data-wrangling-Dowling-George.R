# Dowling George HW 4
#R4DS

library(tidyverse)
library(nycflights13)
library(ggplot2)

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

#Problem 1

people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)

# It can spread the people tibble because Ousman has two different ages
# Can be fixed by having time == 2

#Problem 2

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

#Gather

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

#Problem 3 
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#the second object in vector has 4 observations instead of 3.
#do extra = merge


#Problem 4

# the remove arguement lets the function know if you want to remove the original columns. You might want to keep the original columns for troubleshooting 

# Problem 5

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year) %>%
  summarise(cases = sum(value)) %>%
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  ggplot(aes(year, cases, color = country)) + 
  geom_point() + 
  geom_line()

# Problem 6 

flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(wind_gust_binned  = cut(wind_gust, 
         breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))) %>%
  group_by(wind_gust_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_binned, y = dep_delay)) +
  geom_col()
