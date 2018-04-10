library(tidyverse)
?diamonds

# Question 1

diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram(alpha = .8, binwidth = 30, fill = "red")

# my graph reveals the massive price differential between different diamonds. The vast majority of the diamonds are between some $300-$5000, with a much smaller amount of higher quality diamonds on the far end. 

# Question 2

ggplot(data = diamonds, mapping = aes(x = cut , y = price)) +
  geom_boxplot()

ggplot(data = diamonds, mapping = aes(x = carat , y = price, group = carat)) +
  geom_boxplot()

ggplot(data = diamonds, mapping = aes(x = color , y = price)) +
  geom_boxplot()

ggplot(data = diamonds, mapping = aes(x = clarity , y = price)) +
  geom_boxplot()

summary(diamonds$carat)

# It seems that carat has the biggest effect on price, as there is a clear and steep curve as the carat of the diamond increases. There were some minor differences on the means and higher quartials of clarity, color, and cut, but none as extreme as that in carat.

# Question 3

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()

#