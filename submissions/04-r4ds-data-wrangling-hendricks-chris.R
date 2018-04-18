#r4ds exercise 4

#prepping...

library(tidyverse)
library(nycflights13)

#familiarizing...

?flights
?who

#Starting r4ds questions...

############
#Question 1#
############

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
  spread(key, value)
#Why can't you spread people? How could you add a new column to people to fix the problem?

#The error message informs us that the error is because rows 1 and 3 have duplicate identifiers, in other words there are two entries for Ousmane. One possible way to fix this could be to add in a third column that became a new ID (rather than the name), so that R would treat the two Ousmanes as two different people.

############
#Question 2#
############
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
#Do you need to gather or spread preg to tidy it? What variables are there in preg?

#In order to make this data tidy, we shouldn't have potential variable names as column titles. We can use the gather function to combine the male and female columns into a gender column, and then have it count the entries in that category as the third column.

############
#Question 3#
############

tibble(x = c("a,b,c,NULL", "d,e,f,g", "h,i,j,NULL")) %>% 
  separate(x, c("one", "two", "three", "four"))
#How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

#The warning is saying data was discarded by R. This is because item 2 in the tibble creation has 4 values. The easisest way to fix this so everything gets into the seperate function is to add NULLs to items 1 and 3 and add a "four" section into the code, as detailed above.

############
#Question 4#
############

#Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?
?separate
#the remove argument, if TRUE, removes the original input column from the output. Setting it to false may be useful during the design of the code, as a reminder of its specific data, before it reaches a client ready version, wherein you'd want to remove it.

############
#Question 5#
############

#Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year) %>%
  summarize(cases = sum(value)) %>%
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  ggplot(aes(x = year, y = cases, colour = country)) + 
  geom_line()

#I think the parts that surprise me are obviously the huge jumps in India and China in the 2005-2008 range. Very curious as to why that occured, but it looks like the rise correlates between these nations, so it could be some sort of weather related event. The 0 in Bangladesh data is also interesting, most likely an error in the data and not an actual 1 year hiatus from TB for the entire nation.

############
#Question 6#
############

#Begin by following these steps:
  
#Join observations in flights with those in weather by origin, year, month, day, and hour.
#Bin wind_gust and calculate average dep_delay for each bin.
#Create a bar graph.
#At what gust speeds are departure delays out of NYC the longest on average?

flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(wind_gust_bin   = cut(wind_gust, breaks = seq(5, max(wind_gust, na.rm = TRUE), 5))) %>%
  group_by(wind_gust_bin) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_bin, y = dep_delay)) +
#cant actually do a "bar graph" here because of the y axis, but column is the same thing :P
  geom_col()

#As we can see from the graph, the 35-40 mph wind gusts range results in the highest departure delay.

#done with exercise 4