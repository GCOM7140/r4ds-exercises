library(nycflights13)
library(tidyverse)

# Question 1:
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

# Question 2
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg %>%
  gather(male, female, key = "gender", value = "count")

# Question 3
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")
# error was because row two has an extra item in it, greater than what was expected, you can merge it with the previous item.

# Question 4 - Remove is set to TRUE as a default and will delete the input variable(s) and only keep the product(s) in the dataset. Setting remove to FALSE and keeping the variable could be useful in cases where you may want to use the original variable later

# Question 5
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  filter(country %in% c("China", "India", "Bangladesh")) %>%
  group_by(country, year) %>%
  summarise(cases = sum(value)) %>%
  ggplot(aes(x = year, y = cases, color = country)) +
    geom_line()

# huge abnormality in 2004 for India, sharp increase in number of cases for China in 2006-2007, decrease in 2008 for Bangladesh

# Question 6
flights %>%
  