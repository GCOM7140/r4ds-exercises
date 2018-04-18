#' ---
#' title: "Answers to the R4DS Data Wrangling Exercise"
#' author: Noah Rodammer
#' date: April 17, 2018
#' output: github_document
#' ---

library(tidyverse)
library(nycflights13)
?flights
?who

#' **Question 1**: Why can't you spread people? How could you add a new column 
#' to people to fix the problem?

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

#' Hint: You can use group_by() and row_number() to create a time column that
#' uniquely identifies time periods in people. This time column will fix the 
#' problem.


#' You can't spread people because "Ousmane Diaby" and "age" is repeated
#' without a way to identify between the two. This can be fixed by adding
#' a new column to uniquely identify between the two with time.

people %>%
  group_by(name,key) %>%
  mutate(
    time = row_number()
  ) %>%
  spread(key,value)



#' **Question 2**: Do you need to gather or spread preg to tidy it? 
#' What variables are there in preg?


preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

#' You need to gather the data. The variables are pregnancy, which can be
#' "yes" or "no",  gender which can be "male" or "female", and then the count
#' for each of these, which is irrelevant for men because men cannot be 
#' pregnant. 

preg %>%
  gather('male','female',key="gender",value="count")



#' **Question 3**: How would you explain this warning message in layman's terms
#' to someone who couldn't figure out what it means? Suppose they want to make 
#' sure that every piece of the tibble makes its way into the result of the 
#' separate() function call. What could they do to remedy the situation?


tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

?separate

#' The separate function wants to take each of the rows of a tibble x and 
#' separate the characters into three columns. It depends on what the person
#' wants to do to store all of the data; he/she could add another column "four"
#' whihc would save "b" (see below)
#' 
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three","four"))

#' If he/she wanted to concatinate extra values, he/she could merge the last 
#' ones using the extra parameter (see below)

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"),extra="merge")

#' **Question 4**:Both separate() and unite() have a remove argument. 
#' What does it do? When does setting it to FALSE make sense?

?separate
?unite

#' For separate, the "remove" argument removes the input column from the output 
#' data frame if it is set to "TRUE"
#' For unite, the "remove" argument removes the input columns from the output
#' data frame as well if it is set to "TRUE"
#' 
#' It would make sense to set it to false if you wanted to troubleshoot code


#' **Question 5**:Using the who dataset, calculate the total number of cases 
#' of TB per year for China, India, and Bangladesh, then plot these statistics 
#' over time. What country-year statistics, if any, surprise you?

#'Hint: Build on this code, which tidies who:

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
   group_by(country,year) %>%
  summarize(tb = sum(value)) %>%
  filter(country %in% c("China","India","Bangladesh")) %>%
  ggplot(aes(x=year,y=tb,color=country)) +
  geom_point() +
  geom_line()

#' It is surprising that the number of cases of TB would increase in China,
#' because I would expect that to decrease as China modernizes. Also, the 
#' large spike in India around 2007 is surprising, but I'm not sure if this is 
#' just an error in the data. I also doubt that there were no cases in around
#' 2008 or 2009 of TB in Bangladesh.



#' **Question 6**: Begin by following these steps:
#' 1. Join observations in flights with those in weather by origin, year, 
#' month, day, and hour.
#' 2. Bin wind_gust and calculate average dep_delay for each bin.
#' 3. Create a bar graph.
#' 
#' At what gust speeds are departure delays out of NYC the longest on average?
?cut
flights %>%
  inner_join(weather, by = c("origin","year","month","day","hour")) %>%
  mutate(
    wind = cut(wind_gust,
               breaks = seq(0, max(wind_gust,na.rm=1),5)) 
  ) %>%
  group_by(wind) %>%
  summarize(delay=mean(dep_delay,na.rm=1)) %>%
  ggplot(aes(wind,delay)) +
  geom_col()

#' Bin at 5: The longest are on average between 35 and 40 
#' Bin at 4: The longest are on average between 36 and 40
#' Bin at 3: The longest are on average between 39 and 42
#' Bin at 2: The longest are on average between 38 and 40

