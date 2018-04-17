#' ---
#' title: "Answers to the R4DS 04 Data Wrangling Exercises"
#' author: Robert Papel
#' date: April 9, 2018
#' output: github_document
#' ---

library(tidyverse)
library(nycflights13)

#' **Exercise 1**: Why can't you spread people? How could you add a new column to people to fix the problem?

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
  group_by(name, key) %>% 
  mutate(time = row_number())
  spread(key, value)

#' Answer: There are multiple observations for one variable, or one person (GO
#' Ousy). So that is probably why the console returns "duplciate identifiers."

  
#' **Exercise 2**: Do you need to gather or spread preg to tidy it? What
#' variables are there in preg?

preg <- tribble(
    ~pregnant, ~male, ~female,
    #--------/------/---------
    "yes",        NA,      10,
    "no",         20,      12
  )

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

#' Answer: You probably need to gather if looking at the pregnant column. The
#' variables are values, so they are in string format??

#' **Exercise 3**: How would you explain this warning message in layman's terms
#' to someone who couldn't figure out what it means? Suppose they want to make
#' sure that every piece of the tibble makes its way into the result of the
#' separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#' Answer: The warning message says there was something in the second
#' observatio/object. According to the reading, use the "extra" argument with
#' "merge." This will fix the warning message.

#' **Exercise 4**: Both separate() and unite() have a remove argument. What does
#' it do? When does setting it to FALSE make sense?

#' Answer: Remove is simple, as it tells R to literally remove an object or
#' whatever. If you set it to FALSE, it will do nothing, and will remove
#' nothing.

#' **Exercise 5**: Using the who dataset, calculate the total number of cases of
#' TB per year for China, India, and Bangladesh, then plot these statistics over
#' time. What country-year statistics, if any, surprise you?

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  group_by(country, year) %>% 
  mutate(cases = sum(value)) %>% 
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  ggplot(aes(x = year, y = cases, colour = country)) + 
  geom_point() + 
  geom_line()

#'Answer: Maybe that Bangladesh has a lower number of cases than India, as it is
#'known as a very poor country, compared to India (even knowing that India has
#'large swathes of poor population).

#' **Exercise 6**: At what gust speeds are departure delays out of NYC the
#' longest on average?

flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(wind_gust_binned = cut(wind_gust, 
                                  breaks = seq(0, max(wind_gust, 
                                                      na.rm = TRUE), 5))) %>%
  group_by(wind_gust_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_binned, y = dep_delay)) +
  geom_col()

#' Answer: About 35-40mph range, is when flights are delayed the most. 


         