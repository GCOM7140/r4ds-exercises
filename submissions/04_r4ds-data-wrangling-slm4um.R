library(nycflights13)
library(tidyverse)

#' Question 1: The player tibble below is meant to record De’Andre Hunter and
#' Kyle Guy’s dates of birth and heights. Why can’t you tidy it up with the
#' spread() function? How could you add a new column to player to fix the
#' problem?

player <- tribble(
  ~name,             ~key,     ~value,
  #----------------/---------/-----------------------
  "De'Andre Hunter",    "dob", "December 2, 1997",
  "De'Andre Hunter", "height", 201,
  "De'Andre Hunter",    "dob", "August 11, 1997",
  "Kyle Guy",           "dob", "August 11, 1997",
  "Kyle Guy",        "height", 191
)

# You cannot use the spread() function without prior table manipulation, due to each row not being identified by a unique combination of keys. The entries for data instances 1 and 3 are the same, Name + Key.

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% #searchs for the first unique combination of name and key(?)
  spread(key, value) %>% 
  filter(keep == 1)


#' Question 2: Do you need to gather or spread preg (see below) to tidy it? What
#' variables does preg include?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>%
  gather("male", "female", key = "gender", value = "count")

#' Question 3: How would you explain the warning message below in layman’s terms
#' to someone who couldn’t figure out what it means? Suppose they want to make
#' sure that every piece of the tibble makes its way into the result of the
#' separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three", "four"))

#The second grouping of letters has one more entry than the other groupings. This causes g to be discarded when separating into 3 columns.
#They could either add additional column, "four", to the separate function call or get rid of g.


#' Question 4: Both separate() and unite() have a remove argument. What does it
#' do? When does setting it to FALSE make sense?

#The remove argmuent gets rid of the orginal column being split. It might make
#sense to set its value to FALSE on the first for a separate that you are not
#100% sure about to visually see how it compares to orginial data.

#' Question 5: Using the who dataset, calculate the total number of cases of TB
#' per year for China, India, and Bangladesh, then plot these statistics over
#' time. What country-year statistics, if any, surprise you? You can tidy the
#' who dataset with:

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year) %>%
  summarize(cases = sum(value)) %>%
  filter(country %in% c("China", "India", "Bangladesh")) %>%
  ggplot(aes(x = year, y = cases, colour = country)) +
  geom_point() +
  geom_line()

#Huge spike in TB cases in India around 2007.

#' Question 6: At what wind speeds are departure delays out of NYC the longest
#' on average?

flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  select(dep_delay, wind_speed) %>%
  group_by(wind_speed) %>%
  summarize(Avg_delay = mean(dep_delay, na.rm = TRUE)) %>%
  arrange(desc(Avg_delay)) %>%
  ggplot(aes(x = wind_speed, y = Avg_delay)) + 
  geom_col()

#33.4


