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





