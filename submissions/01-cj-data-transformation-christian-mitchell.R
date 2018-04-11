# DATA TRANSFORMATION EXERCISE #
  # Christian Mitchell

# COMPLETE JOURNEY #

library(tidyverse)
library(completejourney)
library(nycflights13)

transaction_data <- transaction_data %>% 
  select(
    quantity,
    sales_value, 
    retail_disc, coupon_disc, coupon_match_disc,
    household_key, store_id, basket_id, product_id, 
    week_no, day, trans_time
  )

# Question 1

transaction_data <- transaction_data %>%
  mutate(retail_disc = abs(retail_disc), 
         coupon_disc = abs(coupon_disc), 
         coupon_match_disc = abs(coupon_match_disc))

# Question 2

transaction_data <- transaction_data %>%
  mutate(regular_price = 
        (sales_value + retail_disc + coupon_match_disc) / quantity,
         loyalty_price = (sales_value + coupon_match_disc) / quantity,
         coupon_price  = (sales_value - coupon_disc) / quantity) 

# Question 3

n_distinct(transaction_data %>%
  mutate(regular_price = 
           (sales_value + retail_disc + coupon_match_disc) / quantity,
         loyalty_price = (sales_value + coupon_match_disc) / quantity,
         coupon_price  = (sales_value - coupon_disc) / quantity) %>%
  filter(regular_price <= 1) %>%
  select(product_id))

# Question 4

basket <- transaction_data %>%
  group_by(basket_id) %>%
  summarize(
    basket_value = sum(sales_value)) 

basket_value <- basket$basket_value
mean(basket_value > 10)

# Question 5

transaction_data %>%
  filter(
    is.finite(loyalty_price),
    is.finite(regular_price),
    regular_price > 0
  ) %>%
  mutate(pct_loyalty_disc = 1 - (loyalty_price / regular_price)) %>%
  group_by(store_id) %>%
  summarize(store_value = sum(sales_value),
            discount = mean(pct_loyalty_disc)) %>%
  filter(store_value > 10000) %>%
  arrange(desc(discount))

# FLIGHTS #

rm(list = ls())
flights

# Question 1

  # 1

nrow(flights %>% 
  select(dest) %>%
  filter(dest == "LAX")) 

  # 2

nrow(flights %>% 
       filter(origin == "LAX")) 

  # 3

nrow(flights %>%
       filter(distance >= 2000))

  # 4

nrow(flights %>%
       filter(dest %in% c('LAX', 'ONT', 'SNA', 'PSP', 'SBD', 'BUR', 'LGB'),
              origin != 'JFK'))

# Question 2

nrow(flights %>%
       filter(dep_time >= 0,
              is.na(arr_time)))

# Question 3

flights %>%
  arrange(desc(is.na(arr_time)), desc(arr_time))

# Question 4

select(flights, contains("TIME", ignore.case = TRUE))

# Question 5

flights %>%
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(delaymin = sum(dep_delay)) %>%
  mutate(delayprop = delaymin / sum(delaymin)) %>%
  arrange(desc(delayprop)) %>% 
  head(3)