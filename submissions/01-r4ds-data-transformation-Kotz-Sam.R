###

# Question 1

library(tidyverse)
library(nycflights13)

#a. 
nrow(filter(flights, dest == "LAX"))

#b
nrow(filter(flights, origin == "LAX"))

#c
nrow(filter(flights, distance >= "2000"))

#d doesnt work, why? something to do with Tibble?
unlist(flights[,"dest"])
nrow(filter(flights, dest == "LAX"| "ONT"))

#2 
nrow(filter(flights, is.na(arr_time)))

#3
arrange(flights, desc(is.na(arr_time)))

#4
select(flights, contains("TIME"))
# it includes variables with "time" in them... I would probably specifically filter for time based on certain variables using the select function in order to fix this default setting

#5
a<-filter(flights, distance >= "2000")
a<-group_by(a, dest)
summarize(a)
mutate(a)
arrange(a, dep_delay)

#complete journey
library(tidyverse)
library(completejourney)

transaction_data <- transaction_data %>% 
  select(
    quantity,
    sales_value, 
    retail_disc, coupon_disc, coupon_match_disc,
    household_key, store_id, basket_id, product_id, 
    week_no, day, trans_time
  )
#1
?mutate
transaction_data <- mutate(transaction_data, abs(retail_disc))
transaction_data <- mutate(transaction_data, abs(coupon_disc))
transaction_data <- mutate(transaction_data, abs(coupon_match_disc))

#2
transaction_data$regular_price<- mutate(transaction_data, (sales_value + retail_disc + coupon_match_disc) / quantity)
transaction_data$loyalty_price<- mutate(transaction_data, (loyalty_price = (sales_value + coupon_match_disc) / quantity))
transaction_data$coupon_price<- mutate(transaction_data, ((sales_value - coupon_disc) / quantity))

#3 odd error message, can't figure out why
b <- filter(transaction_data, regular_price <= 1)

#4
d<-group_by(transaction_data, basket_id)
summarize(d)
mean(basket_value > 10)

#5
transaction_data$pct_loyalty_disc<- mutate(transaction_data, ( 1 - (loyalty_price / regular_price)))
?group_by
c<-group_by(transaction_data, store_id)
(filter(c, sales_value >= 10000))

