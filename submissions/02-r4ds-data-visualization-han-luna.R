#' ---
#' title: "Answers to the R4DS Data Transformation Exercise"
#' author: Luna Han
#' date: April 2, 2018
#' output: github_document 
#' --- 
knitr::opts_chunk$set(echo = TRUE)
library(tidyverse)
<<<<<<< HEAD
?mpg
#Question 1: Run ggplot(data = mpg). What do you see?
ggplot(data = mpg)

#Question 2: Make a scatterplot of cyl vs displ, then make a boxplot with the same variables. What additional information does the boxplot convey?
#Hint: Use as.factor(cyl) while specifying the boxplot.
ggplot(mpg) + geom_point(mapping = aes( x = cyl, y = displ))
ggplot(mpg) + geom_boxplot(mapping = aes( x = as.factor(cyl), y = displ))

#Question 3: What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.
#Hint: Use geom_bar() with position = "fill". geom_bar() is covered in Section 3.8.
ggplot(mpg) + geom_point(mapping = aes( x = class, y = drv))
ggplot(mpg) + geom_bar(mapping = aes( x = class, fill= drv))

#Question 4: What geom would you use to draw:
#A line chart?
geom_line()
#A boxplot?
geom_boxplot()
#A histogram?
geom_histogram()
#An area chart?
geom_area()

#Question 5: Will these two graphs look different? Why/why not?
  
  ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
# Those two graphs are the same, because you can either put the data and mapping information in the global ggplot function, or into the geom_ fuctions seperately.
=======
library(completejourney)

#Question 1: Create a histogram of quantity. What, if anything, do you find unusual about this visualization?
#This question is designed to strengthen your ability to use geom_histogram().

ggplot(data = transaction_data) +
  geom_histogram(mapping = aes( x = quantity))
#The graph only shows one huge bar.

#Question 2: Use a line graph to plot total sales value by day. What, if anything, do you find unusual about this visualization?
#This question is designed to strengthen your ability to use dplyr verbs in combination with geom_line().

transaction_data %>%
  group_by (day) %>%
  mutate (total_sales_value = sum (sales_value, na.rm = TRUE)) %>%
  ggplot() + 
    geom_line(mapping = aes( x = day, y = total_sales_value))





flights %>% 
  filter(dest == 'LAX') %>% 
  nrow()

#' -   How many flights flew out of LAX?  

flights %>% 
  filter(origin == 'LAX') %>% 
  nrow()

#' -   How many flights are greater than or equal to 2000 miles?  

flights %>% 
  filter(distance >= 2000) %>% 
  nrow()

#' -   How many flights were destined for airports in the Los Angeles area 
#' (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?  

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

#' **Question 2**: How many flights were "ghost flights"? A "ghost flight" is
#' defined as a flight that departed, but never arrived (i.e., has a missing
#' `arr_time`).  

flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

#' **Question 3**: How does
#' [`arrange()`](http://r4ds.had.co.nz/transform.html#arrange-rows-with-arrange)
#' treat missing values? How could you sort all rows with a missing `arr_time`
#' to the top of the dataset?  

#'  
#' With the arrange function, all non-missing values get sorted in ascending or
#' descending fashion; then rows with missing values get displayed. The
#' following code brings missing values to the top, then sorts the observations
#' in descending order:

flights %>% 
  arrange(desc(is.na(arr_time)), desc(arr_time))

#' **Question 4**: What do you observe after running the code below? How does
#' this behavior reflect how
#' [`select()`](http://r4ds.had.co.nz/transform.html#select-columns-with-select)
#' helpers deal with uppercase and lowercase matching by default? How can you
#' change that default?

select(flights, contains("TIME"))

#' The referenced code selects six columns in the `flights` dataset, because the
#'  `contains()` function is not case-sensitive by default. You can set the
#' `ignore.case` argument to `FALSE` to change this behavior as follows:

select(flights, contains("TIME", ignore.case = FALSE))

#' **Question 5**: For each destination greater than or equal to 2000 miles
#' away, compute total minutes of departure delay. Then determine what
#' proportion of total-departure-delay minutes each destination represents. What
#' three destinations top the list?

flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(dep_delay_mins = sum(dep_delay)) %>%
  mutate(dep_delay_pct_of_total = dep_delay_mins / sum(dep_delay_mins)) %>%
  arrange(-dep_delay_pct_of_total) %>% 
  head(3)
>>>>>>> 458fd048b9c0686569d38a1170937e8acc466e82
