library(devtools)
library(tidyverse)
library(completejourney)
transaction_data %>% 
  group_by(household_key) %>%
  summarize(total_household_spend = sum(sales_value))

transaction_data <- transaction_data %>% 
  select(
    quantity,
    sales_value, 
    retail_disc, coupon_disc, coupon_match_disc,
    household_key, store_id, basket_id, product_id, 
    week_no, day, trans_time
  )

#Question 1
?mutate

transaction_data <- transaction_data %>% 
  mutate(
    retail_disc       = abs(retail_disc),
    coupon_disc       = abs(coupon_disc),
    coupon_match_disc = abs(coupon_match_disc)
  )

#Question 2: Create three new variables named regular_price, loyalty_price, and coupon_price according to the following logic:


#regular_price = (sales_value + retail_disc + coupon_match_disc) / quantity
#loyalty_price = (sales_value + coupon_match_disc) / quantity
#coupon_price  = (sales_value - coupon_disc) / quantity

(transaction_data <- transaction_data %>% 
  mutate(
    regular_price     = (sales_value + retail_disc + coupon_match_disc) / 
                        quantity,
    loyalty_price     = (sales_value + coupon_match_disc) / 
                        quantity,
    coupon_price      = (sales_value - coupon_disc) / 
                        quantity
  ) %>% 
  select(regular_price, loyalty_price, coupon_price, everything())
)

#Question 3: transaction_data includes 92,339 unique product IDs. How many of these products (not transactions!) had a regular price of one dollar or less? What does this count equal for loyalty and coupon prices?

transaction_data %>% 
  filter(regular_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()

#regular price of 1$ or less= 12442

transaction_data %>% 
  filter(loyalty_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()

#loyalty price of 1$ or less = 20113

 transaction_data %>% 
  filter(coupon_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()

#coupon price of 1$ or less = 22273

#Question 4: What proportion of baskets are over $10 in sales value?
 
 transaction_data %>%
  group_by(basket_id) %>%
  summarize(basket_value = sum(sales_value)) %>%
  ungroup() %>%
  summarize(proportion_over_10 = mean(basket_value > 10))
 
 # About 65.4% of baskets have a retailer value over 10$

#Question 5: Which store with over $10K in total sales_value discounts its products the most for loyal customers?
 
 #pct_loyalty_disc = 1 - (loyalty_price / regular_price)
 
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
 
 ?is.finite

 #Store 341 has an average discount of 18.8% off for loyalty customers