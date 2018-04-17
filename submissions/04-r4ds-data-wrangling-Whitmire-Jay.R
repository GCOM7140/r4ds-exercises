### Jaywhitmire


# Exercise 1 

?spread
#  Why can't you spread people? How could you add a new column to people to fix the problem?

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

# there are two ousmanes at two differnet ages

people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)

# Exercise 2

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

# Do you need to gather or spread preg to tidy it? What variables are there in preg?

preg %>% 
  gather("male", "female", key = "gender", value = "count")

# Exercise 3

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

#How would you explain this warning message in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

# g was thrown out because there isn;t a third colomn for it to go in.  

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three", "four"))

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')



# Exercise 4
Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

?separate
#If TRUE, remove input column from output data frame.
?unite
# If TRUE, remove input columns from output data frame.

#Setting it to false will keep the input columns, # could be useful later to know what you had

# exercise 5

#Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you?

?who

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>% 
  group_by(country, year) %>% 
  summarise(cases = sum(value)) %>% 
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  ggplot(aes(x = year, y = cases, color = country)) +
  geom_line() + 
  geom_point()
  
#Exercise 6

#Begin by following these steps:
  
#1. Join observations in flights with those in weather by origin, year, month, day, and hour.
#2.  Bin wind_gust and calculate average dep_delay for each bin.
#3.  Create a bar graph.

#At what gust speeds are departure delays out of NYC the longest on average?
flights %>% 
  inner_join( weather, by = c("origin", "year", "month", "day", "hour")) %>% 
              mutate(wg_bin = cut(wind_gust, breaks = seq(0, max(wind_gust, na.rm = T), 10))) %>% 
              group_by(wg_bin) %>% 
              summarise(dep_delay_avg = mean(dep_delay, na.rm = T)) %>% 
              ggplot(aes(x = wg_bin, y = dep_delay_avg)) + 
  geom_col()
            

