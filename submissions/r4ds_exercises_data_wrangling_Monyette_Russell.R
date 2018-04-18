library(tidyverse)
library(nycflights13)


# Question 1

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

people %>% 
  group_by(name, key) %>% 
  mutate(id = row_number()) %>% 
  spread(key, value)


# Question 2

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)


preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

# you need to gather for this question. The varibles in "preg" are pregnant, gender, and count

# Question 3

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

# The argument states that there should be 3 letters in each row, but row 2 has 4 letters, so the warning is telling you it discarded "g"

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = 'merge')

# Question 4

?separate
?unite

# so the remove argument is used to remove input column from an output data frame when set to TRUE. Setting it to false would give you the original columns, which may help when checking back over work


# Question 5

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)%>%
  group_by(country, year)%>%
  summarise(Total_cases = sum(value)) %>%
  filter(country %in% c("China", "India", "Bangladesh")) %>%
  ggplot(aes(x = year, y = Total_cases, color = country)) +
  geom_line()

# India spikes in 2007, but is soon overtaken by China. I wonder what the spike is for?

# Question 6

flights %>%
  inner_join(weather, by = c('origin', 'year', 'month', 'day', 'hour')) %>%
  mutate(
    wind_gust_bin   = cut(wind_gust, 
                             breaks = seq(0, max(wind_gust, na.rm = TRUE), 5))
  ) %>%
  group_by(wind_gust_bin) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_gust_bin, y = dep_delay)) +
  geom_col()

# The longest is for 35-40 MPH winds
