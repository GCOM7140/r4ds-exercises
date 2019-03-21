library(tidyverse)
library(juicelaundry)
# Question 1: Using the transaction dataset, create a new variable called pct_discount that equals how much of a discount customers tend to receive as a percentage of the regular prices that are displayed on The Juice Laundry’s menus (defined as price_charged + discount_given).
transaction <- transaction %>%
  mutate(pct_discount = (discount_given / (discount_given+price_charged)) * 100)


# Question 2: Which stores tend to give larger discounts?

transaction_location <- left_join(transaction, location, by = "location_id")
# Use the filter() and is.finite() functions to exclude transactions that have NaN values for pct_discount. These transactions all have NO_SALE values for the payment_type variable.
transaction_location %>%
  filter (is.finite(pct_discount)) %>%
  group_by(location_name)%>%
  summarize(discounts = mean(pct_discount)) %>%
  arrange(desc(discounts))

# The corner and Preston Avenue tends to give higher discoutns. 

# Question 3: What if we condition on the presence of a discount? Does the answer change?
transaction_location %>%
  filter (is.finite(pct_discount)) %>%
  filter (pct_discount >0) %>%
  group_by(location_name)%>%
  summarize(discounts = mean(pct_discount)) %>%
  arrange(desc(discounts))
# yes, Preston Avenue came on top. 
  
# Question 4: Create a table to display the minimum, maximum, mean, and standard deviation of the price customers paid per transaction for transactions that received and did not receive a discount. What do you notice?

Q_four<-   transaction %>%
    filter(is.finite(pct_discount))%>%
    group_by(discount_given==0) %>%
    summarize(min = min(price_charged),
              max = max(price_charged),
              mean = mean(price_charged),
              sd = sd(price_charged))
  
# Question 5: There are 381,278 rows in the line_item dataset. On how many occasions was a stock keeping unit (SKU) sold for $5 or less, and how many unique SKUs were sold for $5 or less?

  line_item %>%
    filter(quantity != 0)%>%
    mutate(price_per_sku = price_charged/quantity)%>%
    filter(price_per_sku <= 5 )%>%
    select(sku_id)%>%
    summarize(occation = n(),unique=n_distinct(sku_id))
# 47,782 lines with 124 SKU sold for $5 or less. 

# Question 6: What proportion of The Juice Laundry’s transactions involving the sale of one SKU cost customers $10 or more?

line_item%>%
  group_by(transaction_id)%>%
  summarize(transaction_quant = sum(quantity),price_charged=sum(price_charged))%>%
  filter(transaction_quant == 1 )%>%
  summarize(percentage_large_sale = mean(price_charged>=10)*100)
# 38.7% of transactions with only 1 SKU cost over $10. 

  
  