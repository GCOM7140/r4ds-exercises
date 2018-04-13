?diamonds
library(tidyverse)
#Question 1#
ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 30)

#Many of the diamonds' cost are on the far left of the distribution. 

#Question 2#
ggplot(diamonds,aes(x=carat, y=price))+geom_point()
ggplot(diamonds,aes(x=cut, y=price))+geom_point()
ggplot(diamonds,aes(x=color, y=price))+geom_point()
ggplot(diamonds,aes(x=clarity, y=price))+geom_point()

diamonds %>%
  mutate(carat_binned = cut(carat, breaks=c(seq(0, max(carat), .5), 
                                            max(carat)))) %>%
  ggplot(., aes(x=carat_binned, y=price)) + 
  geom_boxplot()
#3#
mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10))

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), 
                                            max(price)), dig.lab=10)) %>%
  ggplot(., aes(price_binned, carat)) + 
  geom_boxplot()

diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, 
                            breaks=c(seq(0, max(price), 5000), Inf), 
                            dig.lab=10)) %>%
  ggplot(., aes(x=carat, fill=price_binned)) + 
  geom_histogram(bins=50, show.legend = FALSE) + 
  facet_wrap(~ price_binned, scales = 'free_y', ncol = 1)
