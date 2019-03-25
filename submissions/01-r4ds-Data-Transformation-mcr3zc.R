#Homework Assignment R4DS 

library(tidyverse)
library(nycflights13)

###QUESTION SET ONE### 

#How many flights flew into LAX 

flights %>% 
    filter(dest =="LAX") %>%
    nrow()

#How many flights flew out of LAX 

flights %>% 
  filter(origin == "LAX") %>% 
  nrow()

#answer was zero, check what is going on

?flights

#How many flights were longer than or equal to 2,000 miles in distance? 

flights %>% 
  filter(distance >= 2000) %>% 
  nrow()


# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>% 
  filter(
    dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"), 
    origin != "JFK"
  ) %>% 
  nrow()

# How many flights were ghost flights? 

```{r include = TRUE, eval = TRUE}
flights %>% 
  filter(!is.na(dep_time), is.na(arr_time)) %>% 
  nrow()

#How does ['arrange()'][arrange] treat missing values and how could you sort all of the rows with a missing 'arr_time' to the top of the dataset? 

```{r include = TRUE, eval = TRUE}
# With the arrange() function, all non-missing values get sorted in ascending or
# descending fashion; then rows with missing values get displayed. The following
# code brings the missing values to the top with desc(is.na(arr_time)):
flights %>% 
  arrange(desc(is.na(arr_time)))




### Complete Journey Problem Set ### 

#install.packages(c("tidyverse", "devtools"))

#devtools::install_github("bradleyboehmke/completejourney")


library(tidyverse)
library(completejourney)



#Question 1: Change the discount variables (i.e., retail_disc, coupon_disc, coupon_match_disc) from negative to positive.
transactions <- transactions %>% 
  mutate(
    retail_disc       = abs(retail_disc),
    coupon_disc       = abs(coupon_disc),
    coupon_match_disc = abs(coupon_match_disc)
  )

#Question 2: Create three new variables named regular_price, loyalty_price, and coupon_price according to the following logic:
(transactions <- transactions %>% 
    mutate(
      regular_price = (sales_value + retail_disc + coupon_match_disc) / 
        quantity,
      loyalty_price = (sales_value + coupon_match_disc) / 
        quantity,
      coupon_price  = (sales_value - coupon_disc) / 
        quantity
    )
)

#Question 3: The transactions dataset includes 68,509 unique product IDs. How many of these products (not transactions!) had a regular price of one dollar or less? What does this count equal for loyalty price and coupon price?


transactions %>% 
  filter(regular_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()

# 8,698 products had a regular price less than or equal to $1.00.

transactions %>% 
  filter(loyalty_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()

# This count for loyalty price is 14,043 products.

transactions %>% 
  filter(coupon_price <= 1) %>% 
  select(product_id) %>% 
  n_distinct()

#Question 4: What proportion of baskets are over $10 in sales value?

transactions %>%
  group_by(basket_id) %>%
  summarize(basket_value = sum(sales_value)) %>%
  ungroup() %>%
  summarize(proportion_over_10 = round(mean(basket_value > 10) * 100, 0))

#Question 5: Which store with over $10K in total sales_value discounts its products the most for loyal customers?

transactions %>%
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


### JUICE LAUNDRY EXERCISE SET ### 

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
