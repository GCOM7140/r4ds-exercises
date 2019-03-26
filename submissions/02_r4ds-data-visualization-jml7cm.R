library(tidyverse)
library(nycflights13)

# Make sure to read the flight data into an object if you want to see all of the variable names and other information. If you are familiar with this dataset or do not need any of this information you can ignore this step. 

dat.flights <- flights

### Question 1 ###

# How many flights flew into LAX?

filter(flights, dest == "LAX")

flights %>%
  filter(dest == "LAX") %>%
  nrow()

# How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()

# How many flights were longer than or equal to 2,000 miles in distance?

flights %>%
  filter(distance >= 2000) %>%
  nrow()

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"),
    origin != "JFK"
  ) %>%
  nrow()

### Question 2 ###

# How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for `arr_time`).

flights %>% 
  filter(!is.na(dep_time), 
         is.na(arr_time)) %>% 
  nrow()

### Question 3 ###

# How does [`arrange()`][arrange] treat missing values, and how could you sort allof the rows with a missing `arr_time` to the top of the dataset?

flights %>% 
  arrange(desc(is.na(arr_time))) %>%
  
# Nrow here returns all the values - which is 336776. 

# The opposite of this code is: 

flights %>% 
  arrange(asc(is.na(arr_time)))

### Question 4 ###

# What do you observe after running the code below? How does this behavior reflect how [`select()`][select] helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?

# ***Professor Boichuk - I saw this note when I was working through the solutions and could not figure out if this was code or not? Should I ignore this?***

select(flights, contains("TIME", ignore.case = TRUE))

### Question 5 ###

# For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)


#' ----
#' R4DS HW #2
#' author: McLean Long
#' date: 3/26/19
#' output: github_document
#' ----
#' 

# This is Assignment 2 - Data Visualizations

library(tidyverse)

library(ggplot2)

### Question 1 ###

ggplot(data = mpg)

# Initially it is just a gray box - which when reading the chapter I thought I had done something incorrectly, but is just a sign that you have begun to work in the "mpg" section of 'ggplot'. 

ggplot(data = mpg) +
geom_point(mapping = aes(x = displ, y = hwy))

# What I see if an interesting spread based on the information within the data. This is covered in R4DS, but I think this visualization of all the individual points is nice. 

### Question 2 ###

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# Both of these visuliazations build on Question 1 and segment the data into two different plots. The boxplot really emphasizes the relationships between engines and cylinders and which relationships are really strong.

### Question 3 ###

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# Initially I just got a plot of points and I was very confused. I went back and read the question and noticed my error. After some trial and error I got an interesting plot that is broken down into a colorful count by the type of vehicle in question.

### Question 4 ### - this info comes from the chapter and I saved it for future use in data visualizations

# Line Chart = geom_line()

# Boxplot = geom_boxplot()

# Histogram = geom_histogram()

# Area Chart =  geom_bar()

### Question 5 ### - this is a question about comparing graphs and whether or not they are identical. Running both allows for an in-depth comparison. 

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# In fact they are identical - they are using different techniques to find this graph, but the end result is the same. This proves the versatility of R. 

### End of code for Exercise 2 ### 