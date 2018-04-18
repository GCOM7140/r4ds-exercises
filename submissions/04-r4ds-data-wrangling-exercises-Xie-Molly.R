library(tidyverse)
library(nycflights13)
?flights 

?who


#Question 1 


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
## There are two values within age for Ousmane which is causing trouble 

people %>% 
  group_by(name, key) %>% 
  mutate(time = row_number()) %>% 
  spread(key, value)



# Question 2 

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>% 
  gather('male', 'female', key = "gender", value = "count")
### You would need to gather 


# Question 3 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))


## Warning: Expected 3 pieces. Additional pieces discarded in 1 rows [2].

## # A tibble: 3 x 3
##   one   two   three
##   <chr> <chr> <chr>
## 1 a     b     c    
## 2 d     e     f    
## 3 h     i     j


# there shoudl be 3 letters in each segemnt but there are 4 in the second one so it is getting dropped 
#This extra letter would need to get dropped from the original for this to work 

# Question 4 

# For unite and separate, the remove removes input columns from the output data frame 
# It could be FALSE is you want to use it later in the project 


# Question 5 

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

## An extremly high outbreak in around 06/07 for CHina 

# Question 6 

flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(bin_wind_gust = cut(wind_gust,
                             breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))) %>%
  group_by(bin_wind_gust) %>%
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(bin_wind_gust, avg_delay)) +
  geom_col()
# the largest delays were when gusts were between 35 and 40 