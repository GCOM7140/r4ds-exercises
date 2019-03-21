library(tidyverse)
library(nycflights13)
#Question 1: Responding to this set of questions requires two steps: (a) finding flights that meet certain criteria and (b) counting these subsets of flights.
  
#1)How many flights flew into LAX? Answer: 16174
nrow(filter(flights, dest == "LAX"))

#2)How many flights flew out of LAX? Answer: 0
nrow(filter(flights, origin == "LAX"))

#3)How many flights were longer than or equal to 2,000 miles in distance? Anwser: 51695
nrow(filter(flights, distance >= 2000))

#4)How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK? Answer: 5737
nrow(filter(flights, origin != "JFK", dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")))

#Question 2: How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).

nrow(filter(flights, !is.na(dep_time), is.na(arr_time)))


#Question 3: How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?
 ##arrange() sorts missing value at the bottom of the column. To lift missing values to the top of a column, 
flights %>%
  arrange(desc(is.na(arr_time)))
#OR, without writing a pipe,
arrange (flights, desc(is.na(arr_time)))


#Question 4: What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?
select(flights, contains("TIME")
       
  #the tibble includes only those columns that contain the word "time" regardless cases

  #to override this default bahavior, set ignore.case = FALSE as indicated in code below to make the function case-sensitive. 
select(flights, contains("TIME", ignore.case = FALSE))

#Question 5: For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

flights %>%
  filter(distance >= 2000, arr_delay > 0)%>%
  group_by(dest)%>%
  summarize(total_arr_delay = sum(arr_delay)) %>%
  mutate(arr_delay_ratio = total_arr_delay / sum(total_arr_delay)) %>%
  arrange(desc(arr_delay_ratio)) %>% 
  head(3)
