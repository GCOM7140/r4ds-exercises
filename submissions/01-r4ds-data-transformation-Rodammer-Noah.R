#############
# FILE INFO #
#############

# Title: GCOMM 7140 Homework 1
# Author: Noah Rodammer


#################
# LOAD PACKAGES #
#################

library(tidyverse)
library(nycflights13)
library(dplyr)
library(devtools)
library(completejourney)

?flights


####################
#  R4DS EXERCISES  #
####################


#################
#  QUESTION #1  #
#################

#How many flights flew into LAX?
nrow(filter(flights, 
            dest=="LAX"))
##16,174

#How many flights flew out of LAX?
nrow(filter(flights, 
            origin=="LAX"))
##0 (all flights are departed from NYC)

#How many flights are greater than or equal to 2000 miles?
nrow(filter(flights, 
            distance>=2000))
##51,695

#How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB) but di not originate out of JFK?
nrow(filter(flights, 
            dest %in% c("LAX","ONT","SNA","PSP","SBD","BUR","LGB") & origin!="JFK"))
##5,737

#################
#  QUESTION #2  #
#################

#How many flights were "ghost flights?" A "ghost flight" is defined as aflight that departed, but never arrived (i.e., has a missing arr_time).
nrow(filter(flights, 
            is.na(arr_time),is.finite(dep_time)))
##458

#################
#  QUESTION #3  #
#################

#How does arrange() treat missing values? How could you sort all rows with a missing arr_time to the top of the dataset?

arrange(flights,
        !is.na(arr_delay))
##It treats it like "NA"
##use the code above

#################
#  QUESTION #4  #
#################

#What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you change that default?

#code below
select(flights, 
       contains("TIME"))
##I observe that the contains statement is not case-sentsitive. By default, then, the select helper acts this way.
##using ignore.case=0 or F as a parameter makes it case sensitive

select(flights,
       contains("TIME",
                ignore.case=0))


#################
#  QUESTION #5  #
#################

#For each destination greater than or equal to 2000 miles away, compute total minutes of DEPARTURE delay. Also determine what proportion of these total minutes of delay the destinations represent. What are the top-three destinations by proportion of total, and what proportions do each of the top-three destinations represent?
?mutate

flights %>%
  filter(distance>=2000,
         dep_delay>0) %>%
  mutate(prop_delay=dep_delay/sum(dep_delay)) %>%
  select(dest,
         prop_delay) %>%
  group_by(dest) %>%
  summarize(delayPercent=sum(prop_delay)) %>%
  arrange(desc(delayPercent))
  
##The top three are SFO, LAX, and LAS. 
##The proportion represents the amount of delay time for each destination airport that is for the departing flights from NYC
