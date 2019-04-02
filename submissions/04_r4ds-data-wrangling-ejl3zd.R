# ++++++++++ r4ds Data Wrangling Exercises ++++++++++

library(nycflights13)
library(tidyverse)

# Question 1: The player tibble below is meant to record De’Andre Hunter and Kyle Guy’s dates of birth and heights. Why can’t you tidy it up with the spread() function? How could you add a new column to player to fix the problem?

player <- tribble(
  ~name,             ~key,     ~value,
  #----------------/---------/-----------------------
  "De'Andre Hunter",    "dob", "December 2, 1997",
  "De'Andre Hunter", "height", 201,
  "De'Andre Hunter",    "dob", "August 11, 1997",
  "Kyle Guy",           "dob", "August 11, 1997",
  "Kyle Guy",        "height", 191
)

# There are two different values for date of birth for De'Andre Hunter. 

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

# Question 2: Do you need to gather or spread preg (see below) to tidy it? What variables does preg include?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

# You need to gather preg, which includes the gender variable.

preg %>%
  gather(`male`, `female`, key = "gender", value = "count")

# Question 3: How would you explain the warning message below in layman’s terms to someone who couldn’t figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

# The second observation "d,e,f,g" has an extra value, which was dropped. This can be fixed by setting the 'extra' argument to "merge". 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

# Question 4: Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

# The "remove" argument removes or keeps the original column or columns being parsed. Setting it to FALSE will keep the original columns, which may make sense for troubleshooting purposes.  

# Question 5: Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the who dataset with:

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

# Answer:
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

# Cases of TB appear to be rising in every country overall. There is also a huge spike in TB cases in India around 2007, which is interesting.

# Question 6: At what wind speeds are departure delays out of NYC the longest on average? You can begin addressing this question by joining observations in the flights dataset of the nycflights13 package with those in weather dataset of the same package by origin, year, month, day, and hour.

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

# Delays out of NYC are longest on average at wind speeds from 30-35 mph.