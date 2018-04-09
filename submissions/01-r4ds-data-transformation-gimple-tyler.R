library(tidyverse)
#install.packages("nycflights13")
library(nycflights13)

#Question 1#
flights %>%
  filter(dest == "LAX") %>%
  select(dest) %>%
  nrow()
#16174

origin<-flights$origin
y<- filter(flights, origin=="LAX")
nrow(y)
#0

flights %>%
  filter(distance >= 2000) %>%
  nrow()
#51695

flights %>%
  filter(dest %in% c("LAX","ONT","SNA", "PSP", "SBD","BUR", "LGB"),origin != "JFK") %>%
  select(dest) %>%
  nrow()
#5737

#Question 2#
flights %>%
  filter(is.na(dep_time) == FALSE, is.na(arr_time) == TRUE) %>%
  select(dep_time, arr_time) %>%
  nrow()  
#458

#Question 3#
flights %>%
  arrange(arr_time) %>%
  select(arr_time)

#Question 4#
select(flights, contains("TIME"))

#Question 5#
flights %>% 
  filter(distance >= 2000, dep_delay > 0) %>%
  group_by(dest) %>%
  summarize(Tdelay = sum(dep_delay)) %>%
  mutate(prop_delay = Tdelay/ sum(Tdelay)) %>%
  arrange(desc(prop_delay))



#Next Assignment#
library(tidyverse)
library(completejourney)
transaction_data <- transaction_data %>% 
  select(
    quantity,
    sales_value, 
    retail_disc, coupon_disc, coupon_match_disc,
    household_key, store_id, basket_id, product_id, 
    week_no, day, trans_time)

#Question 1#
str(transaction_data)
transaction_data
transaction_data <- mutate(transaction_data, retail_disc = abs(retail_disc), 
                           coupon_disc = abs(coupon_disc), 
                           coupon_match_disc = abs(coupon_match_disc))

#Question 2#
(transaction_data <- transaction_data %>%
    mutate(
      regular_price = (sales_value + retail_disc + coupon_match_disc) / quantity,
      loyalty_price = (sales_value + coupon_match_disc) / quantity,
      coupon_price = (sales_value - coupon_disc) / quantity
    ) %>% 
    select(regular_price, loyalty_price, coupon_price, everything()))

#Question3#
n_distinct(
  transaction_data %>% 
    filter(regular_price == 1 | regular_price < 1) %>% 
    select(product_id))
#12442

n_distinct(
  transaction_data %>% 
    filter(loyalty_price == 1 | loyalty_price < 1) %>% 
    select(product_id))
#20113

n_distinct(
  transaction_data %>% 
    filter(coupon_price == 1 | coupon_price < 1) %>% 
    select(product_id))
#22273

#Question4#
transaction_data %>% 
  group_by(basket_id) %>% 
  mutate(basket_value = sum(sales_value)) %>% 
  summarise(proportion = mean(basket_value > 10))

#Question5#
group_by(transaction_data,store_id) %>% 
  filter(sum(sales_value) > 10000) %>% 
  mutate(pct_loyalty_disc = 1 - (loyalty_price / regular_price)) %>% 
  summarize(loyalty_disc = mean(pct_loyalty_disc, na.rm=TRUE)) %>%
  arrange(desc(loyalty_disc))