# test set 1

library(tidyverse)
library(nycflights13)
library(dplyr)

?flights
str(flights)

# Question 1
# 1)
LAXin <- filter(flights, dest == 'LAX')
nrow(LAXin)  # 16174
# 2)
LAXout <- filter(flights, origin == 'LAX')
nrow(LAXout)  # 0
# 3)
f3 <- filter(flights, distance >= 2000)
nrow(f3)  # 51695
# 4)
f4 <- filter(flights, dest %in% c('LAX', 'ONT', 'SNA', 'PSP', 'SBD', 'BUR', 'LGB')
             & !(origin == 'JFK'))
nrow(f4)  # 5737

# Question 2
nrow(filter(flights, !(is.na(dep_time)) & is.na(arr_time)))  # 458

# Question 3
arrange(flights, desc(is.na(arr_time)))

# Question 4
select(flights, contains("TIME"))  # The function is not case sensitive.
select(flights, contains('TIME', ignore.case = FALSE))

# Question 5
f5<- flights %>%
     filter(distance >= 2000 & dep_delay > 0) %>%
     group_by(dest) %>%
     summarise(dep_delay = sum(dep_delay)) %>%
     mutate(proportion = dep_delay / sum(dep_delay))
arrange(f5, desc(proportion))
# The top three are SFO, LAX and LAS



# test set 2

library(tidyverse)
library(completejourney)

# Question 1
t1 <- transaction_data %>% 
  select(
    quantity,
    sales_value, 
    retail_disc, coupon_disc, coupon_match_disc,
    household_key, store_id, basket_id, product_id, 
    week_no, day, trans_time
  ) %>%
  mutate(retail_disc = abs(retail_disc),
         coupon_disc = abs(coupon_disc),
         coupon_match_disc = abs(coupon_match_disc))

# Question 2
t2 <- t1 %>% 
  mutate(regular_price = (sales_value + retail_disc + coupon_match_disc) / quantity,
         loyalty_price = (sales_value + coupon_match_disc) / quantity,
         coupon_price  = (sales_value - coupon_disc) / quantity
  )

# Question 3
t3 <- t2 %>%
      filter(regular_price <= 1) %>%
      select(product_id)
n_distinct(t3)  # 12442

t4 <- t2 %>%
  filter(loyalty_price <= 1) %>%
  select(product_id)
n_distinct(t4)  # 20113

t5 <- t2 %>%
  filter(coupon_price <= 1) %>%
  select(product_id)
n_distinct(t5)  # 22273

# Question 4
t6 <- t2 %>%
      select(basket_id, sales_value) %>%
      group_by(basket_id) %>%
      summarize(basket_value = sum(sales_value)) %>%
      ungroup(basket_id) %>%
      mutate(proportion = mean(basket_value > 10))  # 65.4%

# Question 5
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