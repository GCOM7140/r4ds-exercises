#' title: r4ds Data Wrangling Homework
#' author: Henry Paul
#' date: 3/31/19
#' output: github_document

library(tidyverse)
library(ggplot)
library(nycflights13)


#' **Question 1**: The player tibble below is meant to record De’Andre Hunter and Kyle Guy’s dates of birth and heights. Why can’t you tidy it up with the spread() function? How could you add a new column to player to fix the problem?

player <- tribble(
  ~name,             ~key,     ~value,
  #----------------/---------/-----------------------
  "De'Andre Hunter",    "dob", "December 2, 1997",
  "De'Andre Hunter", "height", 201,
  "De'Andre Hunter",    "dob", "August 11, 1997",
  "Kyle Guy",           "dob", "August 11, 1997",
  "Kyle Guy",        "height", 191
)

#' You cannot spread the data because De'Andre Hunter has two 'dob' entires. To fix this, one must be removed. See script below:

player[-3,] %>% 
  spread(key = "key", value = "value")


#' **Question 2**: Do you need to gather or spread preg (see below) to tidy it? What variables does preg include?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>% 
  gather('male', 'female', key = "gender", value = "cases")


#' **Question 3**: How would you explain the warning message below in layman’s terms to someone who couldn’t figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?  

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#' The issue is that there is one too many entries in column two. This means a new row needs to be added to column 1 and 3.

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")


#' **Question 4**: Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

?separate()
?unite()

#' The remove argument removes the input column from the output dataframe 
#' if "TRUE." A time to set the argument to "FALSE" would be when you want keep
#' the original entry column. An example of this would be during text analyitcs.
#' If you want to seperate phrases into tockens, but still keep the original
#' phrase.


#' **Question 5**: Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the who dataset with:
  
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  filter(country %in% c("China", "India", "Bangladesh")) %>%
  group_by(country, year) %>%
  summarise(total_cases = sum(value)) %>%
  ggplot(mapping = aes(x = year, y = total_cases, color = country)) +
  geom_line() + 
  geom_smooth()

#' It is very surprising that there was such a dramatic spike in 2007 in India. This could be due to a wide range of factors


#' **Question 6**: At what wind speeds are departure delays out of NYC the longest on average?
  
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

