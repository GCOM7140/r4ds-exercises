#install.packages('devtools')
#devtools::install_github('GCOM7140/completejourney', auth_token = '4189f8a8fb56ab1960124916bf980d305b95f0cb')

library(tidyverse)
library(completejourney)

trans_data <- transaction_data %>% 
  select(
    quantity,
    sales_value, 
    retail_disc, coupon_disc, coupon_match_disc,
    household_key, store_id, basket_id, product_id, 
    week_no, day, trans_time)

#1 Change the discount variables (i.e., retail_disc, coupon_disc, coupon_match_disc) from negative to positive.
trans_data <- transaction_data %>% 
mutate(retail_disc = abs(retail_disc), coupon_disc = abs(coupon_disc), coupon_match_disc = abs(coupon_match_disc))
trans_data

#2 Create three new variables named regular_price, loyalty_price, and coupon_price according to the following logic:
#regular_price = (sales_value + retail_disc + coupon_match_disc) / quantity
#loyalty_price = (sales_value + coupon_match_disc) / quantity
#coupon_price  = (sales_value - coupon_disc) / quantity

(trans_data <- transaction_data %>% 
mutate(regular_price = (sales_value + retail_disc + coupon_match_disc) / quantity,
loyalty_price = (sales_value + coupon_match_disc) / quantity,
coupon_price = (sales_value - coupon_disc) / quantity) %>% 
    
select(regular_price, loyalty_price, coupon_price, everything()))

#3 transaction_data includes 92,339 unique product IDs. How many of these products (not transactions!) had a regular price of one dollar or less? What does this count equal for loyalty and coupon prices?

trans_data %>% 
filter(regular_price <= 1) %>% 
select(product_id) %>% 
n_distinct()
#31598

trans_data %>% 
filter(loyalty_price <= 1) %>% 
select(product_id) %>% 
n_distinct()
#20891

trans_data %>% 
filter(coupon_price <= 1) %>% 
select(product_id) %>% 
n_distinct()
#20082

#4 What proportion of baskets are over $10 in sales value? Hint: You need to use group_by(), summarize(), and ungroup(). Summarize over all baskets. In the last step, you can calculate the proportion by taking the mean of TRUE/FALSE values. Use mean(basket_value > 10) to get the proportion over $10.

trans_data
group_by(basket_id) 
summarize(basket_value = sum(sales_value)) 
ungroup() %>%
summarize(proportion_over_10 = mean(basket_value > 10))

#5 Which store with over $10K in total sales_value discounts its products the most for loyal customers?
pct_loyalty_disc = 1 - (loyalty_price / regular_price)
trans_data %>%
  filter(is.finite(regular_price), is.finite(loyalty_price), regular_price > 0) %>%
  mutate(pct_loyalty_disc     = 1 - (loyalty_price / regular_price)) %>%
  group_by(store_id) %>%
  summarize(total_sales_value    = sum(sales_value), avg_pct_loyalty_disc = mean(pct_loyalty_disc)) %>%
  filter(total_sales_value > 10000) %>%
  arrange(desc(avg_pct_loyalty_disc))