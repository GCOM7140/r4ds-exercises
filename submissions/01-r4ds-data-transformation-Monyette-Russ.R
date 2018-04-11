library(Matching)
library(psych)
library(foreign)
library(DBI)
library(readxl)
library(haven)
library(car)
library(effects)
library(corrplot)
library(BaylorEdPsych)
library(ggfortify)
library(cluster)
library(klaR)
library(rrcov)
library(gmodels)
library(QuantPsyc)
library(devtools)
library(tidyverse)
library(nycflights13)
install.packages("nycflights13")

# Question 1
# How many flights flew in?
flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()
# 16174

# How many flights flew out?
flights %>% 
  filter(origin == "LAX") %>% 
  nrow()
# 0


# How many flights are greater than or equal to 2000 miles?
flights %>% 
  filter(distance >= "2000")  %>% 
  nrow()
# 220021

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()
# 5737

# Question 2
# How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing arr_time).

flights %>% 
  filter(is.na(arr_time), !is.na(dep_time)) %>% 
  nrow()
#458

# Question 3
# How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?

flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))


# Question 4
# What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?

select(flights, contains("TIME"))
# I took awhile with this one and had to look at the answers because, for whatever reason, my computer selected the columns with "time" in them regardless of case

# Question 5
# For each destination greater than or equal to 2000 miles away, compute total minutes of departure delay. Then determine what proportion of total-departure-delay minutes each destination represents. What three destinations top the list?

flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)




