##Author: Michael Starnes
##Course:  GCOM 7140
##Instructor:  Professor Boichuk
install.packages("WHO")
install.packages("flights")
install.packages("nycflights13")
install.packages("qadp")
library(tidyverse)
library(WHO)
library(nycflights13)
?flights
?who

#Exercise 1
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
  mutate(time = row_number()) %>% 
  spread(key, value)
## Error: Duplicate identifiers for rows (1, 3)

#Answer: Ousmane has ages listed as 23 and 33, so R fails to understand which one should be printed out since there were two options for the call.  Setting the data with an identifier to make it clear for R would resolve this problem.
## # A tibble: 3 x 4
## # Groups:   name [2]
##   name             id   age height
##   <chr>         <int> <dbl>  <dbl>
## 1 Ousmane Diaby     1   23.   196.
## 2 Ousmane Diaby     2   33.    NA 
## 3 Rich Eldh         1   23.   195.
#This tibble would resolve the error because the two different heights are at different times.


#Excercise 2
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
#this needs to be gathered because it associates a value as a variable name

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")
## # A tibble: 4 x 3
##   pregnant gender count
##   <chr>    <chr>  <dbl>
## 1 yes      male     NA 
## 2 no       male     20.
## 3 yes      female   10.
## 4 no       female   12.


#Exercise 3

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))
How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?
  
#It means that that extra values were dropped from the query, and not delivered.  Telling R to merge and not to warn the user of the extra data would solve this.
  
  
  
#Exercise 4
Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

  # The remove function on separate and unite instructs R to either keep or throw away the extra column being parsed.  Usually it is removed as the default setting, but, it can also help to keep the origial data for posterity rather than removing and therefore lackign it later on.
  
  
#Exercise 5
  who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)

#The spike in the late 2000s in India was interesting, as was the sudden drop in the late 2000s for Bangladesh.  It is interesting to see how although the number of cases is rising, there is little correlation between the three countries from the 2007-2010 range.
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
  


#Exercise 6
Begin by following these steps:
  
  Join observations in flights with those in weather by origin, year, month, day, and hour.
Bin wind_gust and calculate average dep_delay for each bin.
Create a bar graph.
At what gust speeds are departure delays out of NYC the longest on average?
  
  
#Delays seem to be longest between 35 and 40 mph.
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