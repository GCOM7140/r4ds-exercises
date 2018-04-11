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
#Data transformation exercises

#Exercise 1
transaction_data <- transaction_data %>%
  mutate(
    retail_disc = abs(retail_disc),
    coupon_disc = abs(coupon_disc),
    coupon_match_disc = abs(coupon_match_disc)
  )

#Exercise 2
transaction_data <- transaction_data %>%
  mutate(regular_price = (sales_value + retail_disc + coupon_match_disc) / quantity,
         loyalty_price = (sales_value + coupon_match_disc) / quantity,
         coupon_price  = (sales_value - coupon_disc) / quantity
  )

#Exercise 3
?n_distinct
regular_unique <- transaction_data %>%
    filter(regular_price <= 1) %>%
    select(product_id)
  n_distinct(regular_unique)
loyalty_unique <- transaction_data %>%
    filter(loyalty_price <= 1) %>%
    select(product_id)
  n_distinct(loyalty_unique)
coupon_unique <- transaction_data %>%
    filter(coupon_price <= 1) %>%
    select(product_id)
  n_distinct(coupon_unique)

#Exercise 4
?summarize  
transaction_data %>%
  group_by(basket_id) %>%
  summarise(basket_value = sum(sales_value, na.rm = TRUE)) %>%
  ungroup() %>%
  summarise(mean(basket_value > 10))

#Exercise 5
transaction_data %>%
  mutate(pct_loyalty_disc = 1 - (loyalty_price / regular_price)) %>%
  group_by(store_id) %>%
  summarise(store_sales = sum(sales_value, na.rm = TRUE),
            store_discount = mean(pct_loyalty_disc, na.rm = TRUE)) %>%
  filter(store_sales > 10000) %>%
  arrange(desc(store_discount))
  
  
#Data Transformation Exercises Part 2
?flights

#Exercise 1
flights %>%
  filter(dest == "LAX") %>%
  nrow()
flights %>%
  filter(origin == "LAX") %>%
  nrow()
flights %>%
  filter(distance >= 2000) %>%
  nrow()
flights %>%
  filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB")) %>%
  filter(origin != "JFK") %>%
  nrow()

#Exercise 2
flights %>%
  filter(is.na(arr_time)) %>%
  filter(!is.na(dep_time)) %>%
  nrow()

#Exercise 3
?arrange
#Arrange sorts all missing values to the bottom of the dataframe.
arrange(flights, desc(is.na(arr_time)))

#Exercise 4
select(flights, contains("TIME"))
#Selects all columns with time in title. It matches based on the characters in the string and not by case. 
?select
#A function called ignore.case could be used for this purpose.

#Exercise 5
flights %>%
  filter(distance >= 2000) %>%
  group_by(dest) %>%
  summarise(total_dep_delay = sum(dep_delay, na.rm = TRUE)) %>%
  mutate(dep_delay_prop = total_dep_delay/sum(total_dep_delay)) %>%
  arrange(desc(dep_delay_prop))

