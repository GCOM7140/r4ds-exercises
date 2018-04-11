###

# Question 1

library(tidyverse)
library(nycflights13)

#a. 
nrow(filter(flights, dest == "LAX"))

#b
nrow(filter(flights, origin == "LAX"))

#c
nrow(filter(flights, distance >= "2000"))

#d doesnt work, why? something to do with Tibble?
flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

#2 
nrow(filter(flights, is.na(arr_time)))

#3
arrange(flights, desc(is.na(arr_time)))

#4
select(flights, contains("TIME"))
# it includes variables with "time" in them... I would probably specifically filter for time based on certain variables using the select function in order to fix this default setting

#5
a<-filter(flights, distance >= "2000")
a<-group_by(a, dest)
summarize(a)
mutate(a)
arrange(a, dep_delay)

#complete journey
library(tidyverse)
library(completejourney)

transaction_data <- transaction_data %>% 
  select(
    quantity,
    sales_value, 
    retail_disc, coupon_disc, coupon_match_disc,
    household_key, store_id, basket_id, product_id, 
    week_no, day, trans_time
  )
#1
?mutate
transaction_data <- mutate(transaction_data, abs(retail_disc))
transaction_data <- mutate(transaction_data, abs(coupon_disc))
transaction_data <- mutate(transaction_data, abs(coupon_match_disc))

#2
transaction_data$regular_price<- mutate(transaction_data, (sales_value + retail_disc + coupon_match_disc) / quantity)
transaction_data$loyalty_price<- mutate(transaction_data, (loyalty_price = (sales_value + coupon_match_disc) / quantity))
transaction_data$coupon_price<- mutate(transaction_data, ((sales_value - coupon_disc) / quantity))

#3 
transaction_data %>% 
  filter(regular_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()

transaction_data %>% 
  filter(loyalty_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()

transaction_data %>% 
  filter(coupon_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()
#4
transaction_data %>%
  group_by(basket_id) %>%
  summarize(basket_value = sum(sales_value)) %>%
  ungroup() %>%
  summarize(proportion_over_10 = mean(basket_value > 10))

#5
transaction_data %>%
  filter(
    is.finite(regular_price), 
    is.finite(loyalty_price), 
    regular_price > 0
  ) %>%
  mutate(
    pct_loyalty_disc     = 1 - (loyalty_price / regular_price)
  ) %>%
  group_by(store_id) %>%
  summarize(
    total_sales_value    = sum(sales_value), 
    avg_pct_loyalty_disc = mean(pct_loyalty_disc)
  ) %>%
  filter(total_sales_value > 10000) %>%
  arrange(desc(avg_pct_loyalty_disc))
