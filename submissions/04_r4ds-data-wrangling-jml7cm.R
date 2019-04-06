#' Prof. Boichuk - I completely forgot to do the R4Ds exercises in addition to the CJ and TJL work we had for the 4th exercise set. I am turning this in late, but just wanted to let you know. Sorry about that. - McLean 
#' 

### This is the next set of R For Data Science Exercises (R4DS). ###

#' title: "Data Wrangling Exercises for R4DS"
#' output: github_document
#' author: McLean Long

# Remember to load the necessary libraries. This is a step I typically forget, so I am trying to make sure I comment it in to this code, so that I automatically do it whenever I am working in R regardless of assignment or project. 

library(nycflights13)
library(tidyverse)

#' **Question 1**: The `player` tibble below is meant to record De'Andre Hunter and Kyle Guy's dates of birth and heights. Why can't you tidy it up with the [`spread()`][12.3.2] function? How could you add a new column to `player` to fix the problem?

?flights

?who

## As an aside, I loved this question before this weekend's Sweet 16 and Elite 8 games and UVA advancing to the Final 4. This was my favorite question so far in any other R exercises. ##

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

#' **Question 2**: Do you need to [gather][12.3.1] or [spread][12.3.2] `preg` (see below) to tidy it? What variables does `preg` include?

# I find these questions interesting because we are creating data frames from the book and using them to make common sense conclusions. 

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

# Next we assess the data.

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

# Both ways the data is read in show the count. 

#' **Question 3**: How would you explain the warning message below in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the [`separate()`][12.4.1] function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

# I initially thought the code was correct, but after repeatedy gettng the warning message I checked with the solutions and noticed there was a better way to answer this question with the code

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

#' **Question 4**: Both [`separate()`][12.4.1] and [`unite()`][12.4.2] have a `remove` argument. What does it do? When does setting it to `FALSE` make sense?

## This question confused me for a second because I thought we needed to write code, but this is actually a written response question. Setting this to 'FALSE' determines which columns to remove. It does not always remove every single column, but it determines which ones are 'FALSE'. ##

#' **Question 5**: Using the [`who` dataset][12.6], calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the `who` dataset with? 

who

# First I just looked at the Tibble results after seeing how Prof. Boichuk went over tibble results in the console within different data sets in class. 

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

# The question next asks for a visualization. I struggled with the visualization code to be added on to the initial code, but once getting through the code I thought the visualizaiton of the WHO data was really cool. 

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

#' **Question 6**: At what wind speeds are departure delays out of NYC the longest on average? 

# This question uses the NYC Flights dataset that we have previously done some work with in QA semester 1 and Advanced QA.

flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(
    wind_speed_binned = cut_width(wind_speed, width = 5, center = 2.5)
  ) %>%
  group_by(wind_speed_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_speed_binned, y = dep_delay)) +
  geom_col()

# The visualization is really cool for the wind speed ranges and shows that the highest average departure delay occurs within the wind speed range of 30-35 mph. I would have expected 40-45 mph or above would have caused the most delays, but the data in this dataset refutes that earlier assumption. 

### End of code until Exercise 5 for R4Ds ###
