#' ---
#' title: "Answers to the R4DS Data Transformation Exercise"
#' author: Luna Han
#' date: April 2, 2018
#' output: github_document
#' ---

library(tidyverse)
library(completejourney)

#Question 1: Create a histogram of quantity. What, if anything, do you find unusual about this visualization?
#This question is designed to strengthen your ability to use geom_histogram().

ggplot(data = transaction_data) +
  geom_histogram(mapping = aes( x = quantity))
#The graph only shows one huge bar.

#Question 2: Use a line graph to plot total sales value by day. What, if anything, do you find unusual about this visualization?
#This question is designed to strengthen your ability to use dplyr verbs in combination with geom_line().

transaction_data %>%
  group_by (day) %>%
  mutate (total_sales_value = sum (sales_value, na.rm = TRUE)) %>%
  ggplot() + 
    geom_line(mapping = aes( x = day, y = total_sales_value))

#Question 3: Use a bar graph to compare the total sales values of national and private-label brands.Hint: Because transaction_data does not contain product metadata, run the code below to create a new dataset with additional product information in it. Use my_transaction_data for your answer.
my_transaction_data <- left_join(transaction_data, product, by = 'product_id')
my_transaction_data %>%
  group_by(brand) %>%
  mutate (total_sales_value_by_brand = sum (sales_value, na.rm = TRUE)) %>%
  ggplot() +
   geom_bar(mapping = aes( x = brand, y = total_sales_value_by_brand), stat = 'identity')

#Question 4: Building on Question 3, suppose you want to understand whether the retailer's customers' preference for national brands (compared to private-label brands) is stronger in the soft drink category than it is in the cheese category. Examine this supposition by using a stacked bar graph to compare the split between national and private-label brands for soft drinks and cheeses.

#Hint: Follow these three steps to create your plot:
  
#Filter my_transaction_data to include only transactions with commodity_desc equal to "SOFT DRINKS" or "CHEESE"
my_transaction_data %>%
  filter(commodity_desc %in% c('SOFT DRINKS', 'CHEESE')) %>%
#Calculate total sales value by commodity_desc and brand
  group_by(commodity_desc, brand) %>%
  summarise (total_sales_value_2 = sum (sales_value), na.rm = TRUE) %>%
#Create the bars using geom_bar with stat = 'identity' and position = 'fill'
  ggplot() +
    geom_bar (mapping = aes( x = commodity_desc, y = total_sales_value_2, fill = brand), stat = 'identity', position = 'fill') 

#Question 5: The code below filters my_transaction_data to include only peanut better, jelly, and jam transactions. Then it creates a new variable named product_size equal to product size in ounces. Create a bar graph with pb_and_j_data to visualize the distribution of the retailer's PB&J transactions by product size. Which two product sizes are the most popular?

pb_and_j_data <- my_transaction_data %>% 
  filter(commodity_desc == 'PNT BTR/JELLY/JAMS') %>%
  mutate(
    product_size = as.factor(as.integer(gsub('([0-9]+)([[:space:]]*OZ)', '\\1',
                                             curr_size_of_product)))
  )      
    ggplot(pb_and_j_data) + 
      geom_bar(aes(x = product_size))
    