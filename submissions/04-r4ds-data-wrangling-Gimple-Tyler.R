# Starter file for HW 4
#Question 1
library(tidyverse)
library(nycflights13)
?flights
?who
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

people <- people %>% 
  group_by(name, key) %>% 
  mutate(obs = row_number())

people %>% 
  spread(key, value)

#Question 2#
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
preg %>%
  gather(`male`,`female`,key="Gender",value="cases")
#The variables in preg are male and female and cases.#

#Question 3#
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"),remove = TRUE)
#The resulting error is due to there being an extra entry in the second row. The entry g does not fit anywhere in the table and is thus discarded. To remedy this situation you could use the remove function to remove excess data. 
?separate
?Unite
#Question 4#
#In the separate and unite functions, remove will remvoe input column from output data frame. 
#Question 5#
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