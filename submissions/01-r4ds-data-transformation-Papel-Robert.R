## Chapter 5 R4DS Exercises -- Data Transformation Exercises ##

install.packages("nycflights13")

library(tidyverse)
library(nycflights13)

knitr::opts_chunk$set(echo = TRUE)
head(flights)


## Question 1: The following questions ask you to find flights that meet certain
## criteria and then count them. How many flights flew into LAX? How many
## flights flew out of LAX? How many flights are greater than or equal to 2000
## miles? How many flights were destined for airports in the Los Angeles area
## (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

## A) 
nrow(flights %>% 
       filter(dest == "LAX"))

# Answer : 16,174 flights

## B)
nrow(flights %>% 
       filter(origin == "LAX"))

# Answer: 0 >>> Because these are NYC flights!!!!!!!

## C)
nrow(flights %>% 
       filter(distance >= 2000))

# Answer: 51,695 flights     

## D)
nrow(flights %>%
       filter(origin != "JFK") %>% 
       filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")))

# Answer: 5737 flights