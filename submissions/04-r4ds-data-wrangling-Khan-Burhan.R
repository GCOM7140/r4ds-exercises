#' ---
#' title: "R4DS Exercise #4"
#' author: Burhan Khan
#' date: April 14, 2018
#' output: github_document
#' ---

library(tidyverse)
library(nycflights13)

#Question 1

people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|--------|------
  "Phillip Woods",   "age",       45,
  "Phillip Woods",   "height",   186,
  "Phillip Woods",   "age",       50,
  "Jessica Cordero", "age",       37,
  "Jessica Cordero", "height",   156
)

people %>% 
  spread(key, value)

#The spread fails because Phillip Woods has a duplicate age row in his observations

people <- people %>% 
  group_by(name, key) %>% 
  mutate(obs = row_number())

people %>% 
  spread(key, value)

#Question 2:
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)

#You need to gather as there are two columns for gender instead of gender being a row entry

preg %>% 
  gather(male, female, 
         key = "gender", 
         value = "amount")

#Question 3:
q3 <- tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) 
  separate(q3, x, c("one", "two", "three"))

#The message means that the second row has too many observations (4) so one was dropped
  separate(q3, x, c("one", "two", "three", "four"))


  separate(q3, x, c("one", "two", "three"), extra='merge')

  
#Question 4:
  separate(q3, x, c("one", "two", "three", "four"), remove = F)
  
#The remove argument removes your original columns from the outputted data frame. You would want to set it to false if you want to keep the original columns so you can check if the output matches your input.
  

#Question 5:
  clean_who <- who %>%
    gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
    mutate(code = gsub("newrel", "new_rel", code)) %>%
    separate(code, c("new", "var", "sexage")) %>% 
    select(-new, -iso2, -iso3) %>% 
    separate(sexage, c("sex", "age"), sep = 1)
  
clean_who %>% group_by(country, year) %>%
  summarise(tb_num = sum(value)) %>% filter(country %in% c("China", "India", "Bangladesh")) %>%

ggplot(aes(x = year, y = tb_num, col = country)) +
  geom_line() + geom_point() + theme_bw() + ylab("TB Cases")

#There are large spikes and valleys in the dataset across countries


#Question 6:
flights %>%
  inner_join(weather, 
             by = c("origin" = "origin",
                    "year" = "year",
                    "month" = "month",
                    "day" = "day",
                    "hour" = "hour")) %>%
  mutate(wind_gust_binned = cut(wind_gust, breaks=seq(0, max(wind_gust,na.rm=T), 5))) %>%
  group_by(wind_gust_binned) %>%
  summarise(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_binned, y = dep_delay)) +
  geom_col(fill = "lightblue", col = "black", alpha = .9) + theme_bw()
#High wind gusts lead to more delay time