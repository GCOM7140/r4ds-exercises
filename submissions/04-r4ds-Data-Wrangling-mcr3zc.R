#Data Wrangling R for Data Science 

#Load Libraries 
library(nycflights13)
library(tidyverse)

#Question 1: **Question 1**: The `player` tibble below is meant to record De'Andre Hunter and Kyle Guy's dates of birth and heights. Why can't you tidy it up with the [`spread()`][12.3.2] function? How could you add a new column to `player` to fix the problem?

player <- tribble(
~name,             ~key,     ~value,
#----------------/---------/-----------------------
"De'Andre Hunter",    "dob", "December 2, 1997",
"De'Andre Hunter", "height", 201,
"De'Andre Hunter",    "dob", "August 11, 1997",
"Kyle Guy",           "dob", "August 11, 1997",
"Kyle Guy",        "height", 191
)
player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

#Why can't you tidy it up with the spread function 
#spreading the player fails because there are two separate observations for D'Andres date of birth (December 2 1997 and August 11 1997)

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

#Question Two - Do you need to [gather][12.3.1] or [spread][12.3.2] `preg` (see below) to tidy it? What variables does `preg` include?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

#you need to use gather because there are values as variable names. the categories within 'preg' are female/male, gender, and count. 

#Question Three - How would you explain the warning message below in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the[`separate()`][12.4.1] function call. What could they do to remedy the situation?

```{r, echo = TRUE, eval = TRUE, warning = TRUE}
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#The warning message is "expected 3 pieces. Additional pieces discarded in one rows. This is because when you make the designation with 'separate', you give three pieces and then R does not know what to do with the excess information. 
#Adding a merge will encourage the platform to keep it in the three designations. 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

#Question Four - Both [`separate()`][12.4.1] and [`unite()`][12.4.2] have a `remove` argument. What does it do? When does setting it to `FALSE` make sense?

```{r include = TRUE, eval = TRUE}

#The remove argument determines whether R should remove or keep columns, the default is to remove them, but it might make sense to keep the columns sometimes. 

#Question Five - Using the [`who` dataset][12.6], calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the `who` dataset with: 


who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

#Data tided now calculate total # of cases 

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

#There is a very low number of cases for Bangladesh but it is possible these were just never recorded. #In China, there is a dramatic increase that reflects an epidemic. 

#Question Six - at what wind speeds are departure times out of NYC the longest on average? 

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

#Departure times are longest at wind speeds of roughly 35 miles per hour 
  



