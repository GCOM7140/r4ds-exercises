library(nycflights13)
library(tidyverse)

  
#Q1 The `player` tibble below is meant to record De'Andre Hunter and Kyle Guy's dates of birth and heights. Why can't you tidy it up with the [`spread()`][12.3.2] function? How could you add a new column to `player` to fix the problem?
player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

#Q2 Do you need to [gather][12.3.1] or [spread][12.3.2] `preg` (see below) to tidy it? What variables does `preg` include?
  ```{r, echo = TRUE}
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

#Q3 How would you explain the warning message below in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the [`separate()`][12.4.1] function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))
# The warning message says the extra information is dropped, change the argument to merge will solve this problem
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

#Q4 Both [`separate()`][12.4.1] and [`unite()`][12.4.2] have a `remove` argument. What does it do? When does setting it to `FALSE` make sense?

#It decide if R will remove the original colums. Setting it to false will keep the original columns.

#Q5 Using the [`who` dataset][12.6], calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the `who` dataset with:
  
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

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
# The extremely low number of cases in Bangladesh in 2009 might surprise you. It
# is likely an error in the data. For China, the dramatic increase from 2008 to
# 2009 is surprising. For India, 2007 is definitely something worth looking
# into.

#Bangeladesh, the number is quite low.
 
  
#Q6 At what wind speeds are departure delays out of NYC the longest on average? 

flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(
    wind_speed_binned = cut_width(wind_speed, width = 5, center = 2.5)
  ) %>%
  group_by(wind_speed_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_speed_binned, y = dep_delay)) +
  geom_col()
flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  ggplot(aes(x = wind_speed, y = dep_delay)) +
  geom_smooth()
# 30-35 mph wind

