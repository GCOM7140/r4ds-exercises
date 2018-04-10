library(tidyverse)

# Question 1
summary(diamonds$price)

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x=price), binwidth = 30)

#The distribution has a long tail, the majority of the distribution is between $1000 and $5000

#Question 2

ggplot(diamonds, aes(x=carat, y=price)) + 
    geom_point()
ggplot(diamonds, aes(x=cut, y=price)) + 
   geom_point()
ggplot(diamonds, aes(x=clarity, y=price)) + 
   geom_point()
ggplot(diamonds, aes(x=color, y=price)) + 
    geom_point()

#carat has a better distinction to see the the correlation

#Question 3
diamonds %>% 
  filter(!is.na(carat), !is.na(price)) %>%
  mutate(price_binned = cut(price, 
                            breaks=c(seq(0, max(price), 5000), Inf), 
                            dig.lab=10)) %>%
  ggplot(., aes(x=carat, fill=price_binned)) + 
  geom_histogram(bins=50, show.legend = FALSE) + 
  facet_wrap(~ price_binned, scales = 'free_y', ncol = 1)
