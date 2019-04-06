#01-data-transformation-exercises

install.packages(c("nycflights13"))
library(nycflights13)

#**Question 1**
#How many flights flew into LAX?
flights %>% 
  filter(dest == "LAX") %>% 
  nrow()
#16174

#How many flights flew out of LAX?
flights %>% 
  filter(origin == "LAX") %>% 
  nrow()
#0

#How many flights were longer than or equal to 2,000 miles in distance?
flights %>% 
  filter(distance >= 2000) %>% 
  nrow()
#51695

#How many flights were destined for airports in the Los Angeles area (LAX,ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()
#5737

#**Question 2**
#How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for `arr_time`).
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()
#458

#**Question 3**
#How does [`arrange()`][arrange] treat missing values, and how could you sort all of the rows with a missing `arr_time` to the top of the dataset?
flights %>% 
  arrange(desc(is.na(arr_time)))

#**Question 4**:
#What do you observe after running the code below? How does this behavior reflect how [`select()`][select] helpers deal with uppercase and lowercase matching by default? How can you override this default behavior? 
select(flights, contains("TIME")) 
select(flights, contains('TIME', ignore.case = FALSE))
#when setting up as default, select function is not casewise; if casewise is needed, we should add ignore.case = F.

#**Question 5**:
#For each destination more than or equal to 2,000 miles away from NYC's airports,compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the totalnumber of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?
flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)
#The total delay time are : SFO: 205406 min, LAX: 203226 min, LAS: 73947 min
#The percentages are: SFO: 29.1%, LAX: 28.8%, LAS: 10.5%
#Top3 lists are: SFO, LAX, LAS
