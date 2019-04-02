#' ---
#' Author: John Anderson
#' Title: 
#' Date:
#' Output: github_document
#' ---

library(tidyverse)
library(nycflights13)

#' **Question 1**: The `player` tibble below is meant to record De’Andre
#' Hunter and Kyle Guy’s dates of birth and heights. Why can’t you tidy it
#' up with the function? How could you add a new column to `player` to fix the problem?

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

#' First this tribble has two values for De'Andre's DOB so this results in an error.You have to add a keep value column  and then can filter by keep == 1 to select only a single DOB

#' Question 2: Do you need to gather or spread preg (see below) to tidy it? What variables does preg include?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>%
  gather("male", "female", key = "gender", value = "age")

#' We need to gather by age and gender since the column names are also values for variables

#' Question 3: How would you explain the warning message below in layman’s terms to someone who couldn’t figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#' when you look at how the tibble was created there is an additional (4th) value in the second row. This warning is saying the tibble expected 3 but found 4 so it removed the last value

#' Question 4: Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

#' The remove argument for separate and unite allow you to keep or remove the original column you started with. This is automatically removed however keeping it could be useful for understanding the original data set and troubleshooting future problems.

#' Question 5: Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the who dataset with:

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year) %>%
  summarize(total_tb = sum(value)) %>%
  filter(country %in% c("China", "India", "Bangladesh")) %>%
  ggplot(mapping = aes(x = year, y = total_tb, color = country)) +
  geom_line() +
  geom_point()

#' Bangladesh is extremely low compared to China and India. Additionally India had a massive spike in 2007 that should be investigated. Very abmormal

#' Question 6: At what wind speeds are departure delays out of NYC the longest on average?

flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(
    wind_speed_binned = cut_width(wind_speed, width = 5, center = 2.5)
  ) %>%
  group_by(wind_speed_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_speed_binned, y = dep_delay)) +
  geom_col()









