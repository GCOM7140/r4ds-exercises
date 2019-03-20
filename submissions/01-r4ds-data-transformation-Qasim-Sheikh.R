install.packages("tidyverse")
install.packages("nycflights13")
library(tidyverse)
library(nycflights13)
df <- flights

head(df)
names(df)

#Question 1

#How many flights flew into LAX?

sum(df$dest == "LAX")

#How many flights flew out of LAX?

#the dataset is for NYC flights, so none

#How many flights were longer than or equal to 2000 miles in distance?

sum(df$distance >= 2000)

#Question 2: How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

sum((df$dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")) & df$origin != "JFK")

flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

#Question 3: How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?

#Arrange puts all missing values at the bottom. To have them put at the top, you have to specifically ask for it using arrange(desc(is.na(arr_time)))


#Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?

select(flights, contains("TIME"))

#This code gets all the columns in the flights dataset that have time in their name. It is not case sensitive. This default can be changed by modifying the parameter in the select statement. 

#Question 5

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)