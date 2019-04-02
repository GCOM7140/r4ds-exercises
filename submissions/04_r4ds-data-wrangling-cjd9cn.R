#############################
# Chris Dowdy April 2       #
# r4ds                      #
# Data Wrangling            #
#############################

library(nycflights13)
library(tidyverse)


# Question 1: The player tibble below is meant to record De’Andre Hunter and
# Kyle Guy’s dates of birth and heights. Why can’t you tidy it up with the
# spread() function? How could you add a new column to player to fix the
# problem?

player <- tribble(
  ~name,             ~key,     ~value,
  #----------------/---------/-----------------------
  "De'Andre Hunter",    "dob", "December 2, 1997",
  "De'Andre Hunter", "height", 201,
  "De'Andre Hunter",    "dob", "August 11, 1997",
  "Kyle Guy",           "dob", "August 11, 1997",
  "Kyle Guy",        "height", 191
)

# Spreading doesn't work because there are two different dates for De'Andre's
# DOB. We can drop the wrong value with the function keep ==.

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)


# Question 2: Do you need to gather or spread preg (see below) to tidy it? What
# variables does preg include?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

# preg needs to be gathered because it has values as variable names. The variables in 'preg` are `pregnant`, `gender`, and `count`.


# Question 3: How would you explain the warning message below in layman’s terms
# to someone who couldn’t figure out what it means? Suppose they want to make
# sure that every piece of the tibble makes its way into the result of the
# separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

# The warning message indicates that the second observation has an extra piece
# of information, and that this extra piece was dropped. Setting the `extra`
# argument to "merge"" rather than "warn", its default, remedies this situation.

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")


# Question 4: Both separate() and unite() have a remove argument. What does it
# do? When does setting it to FALSE make sense?

# The `remove` argument determines whether R should remove or keep the original
# column(s) being parsed. The default is to remove the column(s); however, it
# might make sense to keep the original column(s) for troubleshooting purposes
# or another operation in certain situations.


# Question 5: Using the who dataset, calculate the total number of cases of TB
# per year for China, India, and Bangladesh, then plot these statistics over
# time. What country-year statistics, if any, surprise you? You can tidy the who
# dataset with:

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

# The 09 Bangladesh finding is suprising.


# Question 6: At what wind speeds are departure delays out of NYC the longest on average?

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

# Departure delays are longest when wind speeds are between 30 and 35 mph.