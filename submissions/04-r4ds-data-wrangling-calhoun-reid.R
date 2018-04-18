# Reid Calhoun
# April 17, 2018
# R4DS Homework 4 - Data Wrangling


library(tidyverse)
library(nycflights13)

?flights
?who

##################
### Exercise 1 ###
##################


people <- tribble(
  ~name,            ~key,     ~value,
  #---------------/---------/--------
  "Ousmane Diaby",    "age",      23,
  "Ousmane Diaby", "height",     196,
  "Ousmane Diaby",    "age",      33,
  "Rich Eldh",        "age",      23,
  "Rich Eldh",     "height",     195
)

# Commented phrase below does not work
#people %>% 
#  spread(key, value)

# Why can't you spread people? How could you add a new column to people to fix the problem?
# You cannot spread people because there is a duplicate of age
# Good to create a separate identifier then for consecutive cases

people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)



##################
### Exercise 2 ###
##################


preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)


# Do you need to gather or spread preg to tidy it? What variables are there in preg?

# need to gather preg to tidy it
preg %>% 
  gather('male','female', key = 'gender', value = 'count')



##################
### Exercise 3 ###
##################

# following piece of code produces an error message
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

# How would you explain this warning message in layman's terms to someone who 
# couldn't figure out what it means? Suppose they want to make sure that every
# piece of the tibble makes its way into the result of the separate() function
# call. What could they do to remedy the situation?

# The warning message shows that the command was expecting three columns but one row had four columns of information
# They could use the separate function with extra told to merge when there are too many pieces

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")


##################
### Exercise 4 ###
##################

# Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

# removes the original input data frame because the new tibble is created.
# Might be good to keep original data for troubleshooting purposes though.


##################
### Exercise 5 ###
##################


# Using the who dataset, calculate the total number of cases of TB per year for
# China, India, and Bangladesh, then plot these statistics over time. What
# country-year statistics, if any, surprise you?

# Begin with the following code, which tidies who
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  group_by(country,year) %>%
  summarize(cases = sum(value)) %>% 
  filter(country %in% c('China','India','Bangladesh')) %>%
  ggplot(aes(year, cases, color = country))+
  geom_point()+
  geom_line()
  

##################
### Exercise 6 ###
##################


# At what gust speeds are departure delays out of NYC the longest on average?


flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(
    wind_gust_binned = cut(wind_gust,
                           breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))
  ) %>%
  group_by(wind_gust_binned) %>%
  summarize(avg_dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_binned, y = avg_dep_delay))+
  geom_col()
              

