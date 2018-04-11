#homework 3 customer analytics

#question 1

library(tidyverse)
?diamonds

diamonds %>% 
  ggplot(aes(price), binwidth=30) + 
  geom_histogram()
# there are many more diamonds with a price close to 1000, and the number of diamonds decrease as the price increases. nontheless as the price gets close to 5000 there is a rebump.

#question 2

ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point()
ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_boxplot()
ggplot(data = diamonds, mapping = aes(x = clarity, y = price)) +
  geom_boxplot()
ggplot(data = diamonds, mapping = aes(x = color, y = price)) +
  geom_boxplot()
 #carat seems to have a stronger relationship but for better comparison a boxplot creation will help.

diamonds %>%
  mutate(carat_binned = cut(carat, breaks=c(seq(0, max(carat), .5), max(carat)))) %>%
  ggplot(., aes(x=carat_binned, y=price)) + 
  geom_boxplot()

#question 3
# the previous technique used above can be replicated to first "bin" price in increaments of 5000 and use boxplot while treating it as a categorical variable.
diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()
