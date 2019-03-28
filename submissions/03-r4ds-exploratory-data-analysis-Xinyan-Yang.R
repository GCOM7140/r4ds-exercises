
library(tidyverse)
library(juicelaundry)



#Q1 Using `transaction`, create a customer-level dataset with median
transaction %>%
  group_by(customer_id) %>%
  summarize(spend_median = median(price_charged))

#Q2 Building on Question 2, create a histogram to plot the

transaction %>%
  group_by(customer_id) %>%
  summarize(spend_median = median(price_charged)) %>%
  ggplot(aes(x = spend_median)) + 
  geom_histogram(binwidth = 5, center = 2.5, closed = "left") +
  coord_cartesian(xlim = c(0, 30))

#Q3 Are customers who order a salad more likely than average toorder a juice, too? That is, calculate [lift][Wikipedia, lift] for the association rule" that a salad in a transaction (i.e., `product_name ==  "SALAD"`) implies that a cold-press juice is in the same transaction (i.e., `product_name == "COLD-PRESSED JUICES"`). Does the association between these products offer support for the notion that customers purchase juice to go withtheir salads?
  
line_item %>% 
  inner_join(sku, by = "sku_id") %>%
  mutate(
    a  = product_name     == "SALAD",
    b  = product_category == "COLD-PRESSED JUICES"
  ) %>%
  group_by(transaction_id) %>%
  summarize(
    transaction_has_a = max(a), 
    transaction_has_b = max(b)
  ) %>%
  summarize(
    prop_both  = sum(transaction_has_a * transaction_has_b == 1) /
      sum(transaction_has_a == 1),
    prob_b     = mean(transaction_has_b),
    lift_a     = prop_both / prob_b
  )
