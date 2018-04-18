#----------------------------------------------------------------
#Rich Eldh
#Professor Boichek
#Customer Analytics
#Assignment #4
#Due Date: 17 April 2018
#----------------------------------------------------------------

#----------------------------------------------------------------
#R4DS Exercises
#----------------------------------------------------------------

library(tidyverse)
library(nycflights13)

#----------------------------------------------------------------
#Question 1
#----------------------------------------------------------------

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

#There are two different Ousmanes, or Ousmane recorded at two different times. This is shown by the duplicate age values.

people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)

#----------------------------------------------------------------
#Question 2
#----------------------------------------------------------------

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

#Preg data needs to be gathered.

preg %>% 
  gather('male', 'female', key = "sex", value = "count")


#----------------------------------------------------------------
#Question 3
#----------------------------------------------------------------
?separate
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#The warning indicates that the "two" value had four observations or descriptive attributes, but one had to be dropped because it did not fit into the data table.

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

#----------------------------------------------------------------
#Question 4
#----------------------------------------------------------------

#The remove function is automatically set to remove columns that are being considered. However, you may want to keep them incorporated for experimental purposes in future analyses.

#----------------------------------------------------------------
#Question 5
#----------------------------------------------------------------

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

#The spike in India around 2007 from approximately 560,000 cases to approximately 1,200,000 is quite unusual, along with the spike in China in 2008 that did not subside afterwards. 

#----------------------------------------------------------------
#Question 6
#----------------------------------------------------------------

flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(
    wind_gust_bin   = cut(wind_gust, 
                             breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))) %>%
  group_by(wind_gust_bin) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_bin, y = dep_delay)) +
  geom_col()

#Departure delays are most frequent when wind gusts blow at between 35 and 40 mph. 