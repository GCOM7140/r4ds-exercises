#####################################
### GCOM 7140 (Customer) ############
### Data Transformation Exercises ###
### Complete Journey              ###
### 3/21/19                       ###
#####################################


### file name: 01_cj-data-transformation-Forbes-Kaysha.R


library(tidyverse)
library(completejourney)


### Question 1: Change the discount variables (i.e., retail_disc, coupon_disc, coupon_match_disc) from negative to positive.

transactions <- transactions %>%
  mutate( 
    retail_disc = abs(retail_disc), 
    coupon_disc = abs(coupon_disc), 
    coupon_match_disc = abs(coupon_match_disc)
  )


### Question 2: Create three new variables named regular_price, loyalty_price, and coupon_price according to the following logic:

transactions <- transactions %>%
  mutate( 
    regular_price = (sales_value + retail_disc + coupon_match_disc) / quantity, 
    loyalty_price = (sales_value + coupon_match_disc) / quantity, 
    coupon_price  = (sales_value - coupon_disc) / quantity
  )


### Question 3: The transactions dataset includes 68,509 unique product IDs. How many of these products (not transactions!) had a regular price of one dollar or less? What does this count equal for loyalty price and coupon price?

## regular price:
transactions %>%
  filter(regular_price <= 1) %>%
  select(product_id) %>%
  n_distinct()
# Answer: 8698 products

## loyalty price:
transactions %>%
  filter(loyalty_price <= 1) %>%
  select(product_id) %>%
  n_distinct()
# Answer: 14043 products

## coupon price:
transactions %>%
  filter(coupon_price <= 1) %>%
  select(product_id) %>%
  n_distinct()
# Answer: 15676 products


### Question 4: What proportion of baskets are over $10 in sales value?

transactions %>%
  group_by(basket_id) %>%
  summarize(basket_value = sum(sales_value)) %>%
  ungroup() %>%
  summarize(prop_baskets_10 = mean(basket_value > 10))
# Answer: 66.1% of baskets


### Question 5: Which store with over $10K in total sales_value discounts its products the most for loyal customers?

transactions %>%
  filter(
    is.finite(regular_price), 
    is.finite(loyalty_price), 
    regular_price > 0
  ) %>%
  mutate(pct_loyalty_disc = 1 - (loyalty_price / regular_price)) %>%
  group_by(store_id) %>%
  summarize(
    store_value = sum(sales_value), 
    avg_prop_store_loyalty = mean(pct_loyalty_disc)
  ) %>%
  arrange(desc(avg_prop_store_loyalty)) %>%
  filter(store_value > 10000)
# Answer: Store #341
