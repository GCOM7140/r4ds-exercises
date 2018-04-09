
#### Question 1: Change the discount variables (i.e., retail_disc, coupon_disc, coupon_match_disc) from negative to positive.
transaction_data <- mutate(transaction_data, retail_disc = abs(retail_disc), coupon_disc = abs(coupon_disc), coupon_match_disc = abs(coupon_match_disc))
transaction_data


##### Question 2: Create three new variables named regular_price, loyalty_price, and coupon_price according to the following logic:
transaction_data <- mutate(transaction_data, regular_price = (sales_value + retail_disc + coupon_match_disc) / quantity,
       loyalty_price = (sales_value + coupon_match_disc) / quantity,
       coupon_price  = (sales_value - coupon_disc) / quantity)

####Question 3: transaction_data includes 92,339 unique product IDs. How many of these products (not transactions!) had a regular price of one dollar or less? What does this count equal for loyalty and coupon prices?

reg_price_1_or_less <- filter(transaction_data, regular_price <= 1)

n_distinct(reg_price_1_or_less$product_id)
n_distinct(reg_price_1_or_less$loyalty_price)
n_distinct(reg_price_1_or_less$coupon_price)

# 12442 products, 17338 loyalty prices, 17531 coupon prices

#### Question 4: What proportion of baskets are over $10 in sales value?

baskets_over_10 <- group_by(transaction_data, basket_id)
baskets_over_10 <- summarize(baskets_over_10, basket_value = sum(sales_value))
baskets_over_10 <- filter(baskets_over_10, basket_value > 10)
n_distinct(baskets_over_10$basket_id) / n_distinct(transaction_data$basket_id)
# 65.3% of baskets are over $10

#### Question 5: Which store with over $10K in total sales_value discounts its products the most for loyal customers?
sales_value_over_10k <- group_by(transaction_data, store_id)
sales_value_over_10k <- summarise(sales_value_over_10k, sales_value_sum = sum(sales_value), pct_loyalty_disc = 1 - (sum(loyalty_price) / sum(regular_price)))
sales_value_over_10k <-  filter(sales_value_over_10k, sales_value_sum > 10000)
sales_value_over_10k <- arrange(sales_value_over_10k, desc(pct_loyalty_disc))
sales_value_over_10k



##### ANSWERSSSSSSS ###########




