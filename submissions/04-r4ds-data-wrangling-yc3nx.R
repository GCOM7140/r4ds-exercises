library(nycflights13)
library(tidyverse)
library(tidyr)



# Question 1: The player tibble below is meant to record De’Andre Hunter and Kyle Guy’s dates of birth and heights. Why can’t you tidy it up with the spread() function? How could you add a new column to player to fix the problem?
  
  # We developed this question based on the third exercise in section 12.3.3 of R4DS. It is designed to strengthen your understanding of how spread() behaves with non-unique rows.

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
  group_by(key)%>%
  mutate(keep == 2)%>%
  ungroup()%>%
  spread(key,value)%>%
  filter(keep == 1 )

#  because the variable include non-unique value in "value" for unique keys. 


# Question 2: Do you need to gather or spread preg (see below) to tidy it? What variables does preg include?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

preg%>%
  gather("gender","num_of_ppl",male:female)%>%
  filter(!is.na(num_of_ppl))
# by gathering, and filtering out number of ppl 


# Question 3: How would you explain the warning message below in layman’s terms to someone who couldn’t figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  # separate(x, c("one", "two", "three"))
    separate(x, c("one", "two", "three"), extra = "merge")
# separate requires the rows to be in the same length. row 2 has one extra entity. 
# by merging the extra piece in row 2, all entities will show. 

# Question 4: Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

# remove argument remove input column from output dataframe. It makes sense the function creates redundancy in information otherwise. 
# When the results of separate and unite gives an undesireable results, putting the original column back can help troubleshoot. 

# Question 5: Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the who dataset with:

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1)%>%
  group_by(country,year)%>%
  summarize(cases = sum(value))%>%
  filter(country %in% c("China","India","Bangladesh"))%>%
  ggplot(aes(year,cases,color = country))+
  geom_point()+
  geom_line()

# China's TB cases experience a sudden increase in 2009, while India seemed to have a TB outbreak in 2007.  

# Question 6: At what wind speeds are departure delays out of NYC the longest on average?
  
  # You can begin addressing this question by joining observations in the flights dataset of the nycflights13 package with those in weather dataset of the same package by origin, year, month, day, and hour.


flights %>% 
 inner_join(select(weather,origin, year,month,day,hour,wind_speed),
            by=c("origin","year","month","day","hour"))%>%
  mutate(wind_speed_bin = cut_width(wind_speed,5))%>%
  group_by(wind_speed_bin)%>%
  summarize(dpt_delay = mean(dep_delay, na.rm= T))%>%
  filter(!is.na(wind_speed_bin))%>%
  ggplot(aes(wind_speed_bin,dpt_delay))+
  geom_bar(stat="identity")

# 32.5 - 37.5 mph windspeed has the longest delay. 






  