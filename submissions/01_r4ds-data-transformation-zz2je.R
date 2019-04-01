library(tidyverse)
library(nycflights13)

# Question1
# How many flights flew into LAX? ---> 16174 flights flew into LAX
flights %>%
  filter(dest == "LAX" )%>%
  nrow()

# How many flights flew out of LAX? ---> 0 flights flew into LAX
flights %>%
  filter(origin == "LAX" )%>%
  nrow()

# How many flights were longer than or equal to 2,000 miles in distance? ---> 51695 were longer than or equal to 2,000 miles in distance
flights %>%
  filter(distance >= 2000 )%>%
  nrow()

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK ---> 5737 flights
flights %>%
  filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB") & origin != "JFK")%>%
  nrow()


# Question2 How many flights were "ghost flights"? ---> 458 flights
flights %>%
  filter(!is.na(dep_time) & is.na(arr_time))%>%
  nrow()


# Question3 How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset? ---> arrange() always sorts missing values to the end 
flights %>% 
  arrange(desc(is.na(arr_time)))


# Question4 What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?
select(flights, contains("TIME"))
select(flights, contains("TIME",ignore.case = TRUE))
#----> It can return as desired. As contains has the ignore.case = TRUE by default so it is NOT case-sensitive.If change ignore.case = FALSE, it won't return anything.
       

# Question5 For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list? 
#----> top three: SFO, LAX, and LAS

flights %>%
  filter(distance>= 2000 & arr_delay >0) %>%
  group_by(dest)%>%
  summarise(delay=sum(arr_delay)) %>%
  mutate(prop=delay/sum(delay))%>%
  arrange(desc(delay))%>%
  head()
  