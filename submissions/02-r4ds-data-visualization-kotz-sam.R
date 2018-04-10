#HW 2 Sam Kotz

#R4DS Questions
#1
library(tidyverse)
ggplot(data = mpg)

# I see a gray box... seems like the basis for more advanced plots.

#2
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

#box plot shows a similar trend, but with medians and IQR's

#3
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
# just looking at this plot shows not obvious trend and it's extremely difficult to read
#better option... pretty cool relative bar graph
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv))

#4
#geom_line()
#geom_boxplot()
#geom_histogram()
#geom_area() or geom_bar()

#5
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#same, it's mostly a matter of preference choosing between the two

#Complete Journey Questions
#1
library(completejourney)
ggplot(data = transaction_data) + 
  geom_histogram(mapping = aes(x = quantity))

#really tall bar at 0, then long tail all the way to 20000 which is very strange

#2
transaction_data %>% 
  group_by(day) %>% 
  summarize(total_sales_value = sum(sales_value)) %>%
  ggplot() + 
  geom_line(mapping = aes(x = day, y = total_sales_value))

# I immidiately notice the strange one day spikes and then dips to near zero, which is very strange

#3

my_transaction_data <- left_join(transaction_data, product, by = 'product_id')

my_transaction_data %>%
  group_by(brand) %>%
  summarize(total_sales_value = sum(sales_value)) %>%
  ggplot() + 
  geom_bar(
    mapping = aes(x = brand, y = total_sales_value), 
    stat = 'identity')


#4
my_transaction_data %>%
filter(commodity_desc %in% c('SOFT DRINKS', 'CHEESE')) %>%
  group_by(commodity_desc, brand) %>%
  summarize(total_sales_value = sum(sales_value)) %>%
  ggplot() + 
  geom_bar(
    mapping  = aes(x = commodity_desc, y = total_sales_value, fill = brand), 
    stat     = 'identity', 
    position = 'fill'
  )

#5
pb_and_j_data <- my_transaction_data %>% 
  filter(commodity_desc == 'PNT BTR/JELLY/JAMS') %>%
  mutate(
    product_size = as.factor(as.integer(gsub('([0-9]+)([[:space:]]*OZ)', '\\1',
                                             curr_size_of_product)))
  )

ggplot(pb_and_j_data) + 
  geom_bar(aes(x = product_size))

#18 and 32 oz are the most populat