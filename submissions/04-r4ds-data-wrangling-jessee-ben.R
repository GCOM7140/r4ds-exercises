#r4ds Data Wrangling
#Ben Jessee

library(tidyverse)
library(nycflights13)

#Why can't you spread people? How could you add a new column to people to fix the problem?

  #Spreading people doesn't work because there are 2 different ages for Ousmane. This could be fixed by adding a new variable to distinguish between the 2 ages like time

#Do you need to gather or spread preg to tidy it? What variables are there in preg?

  #Gather because there are values as variable names. 
  #Variables in preg are pregnant, gender, and count

#How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

  #This warning message indicates that there are more values than can be fit in     the3x3 tibble. This can be fixed by changing the "extra" argument from "warn" to "merge"

#Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

  #Remove: Decide to remove or keep original columns being parsed
  #Seeing it to false (keeping the columns) may make sense to troubleshoot errors

#Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?

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

  #The spike in 2007 for India and the near zero numbers for several years in Bangladesh are surprsing and warrant further investigation.

#At what gust speeds are departure delays out of NYC the longest on average?

flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(
    wind_gust_binned   = cut(wind_gust, 
                             breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))
  ) %>%
  group_by(wind_gust_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_binned, y = dep_delay)) +
  geom_col()

  #35-40 mph
