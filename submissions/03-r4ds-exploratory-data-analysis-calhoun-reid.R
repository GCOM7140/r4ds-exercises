# Reid Calhoun
# April 10, 2018
# R4DS Assignment 3

library(tidyverse)
?diamonds 
##################
### Question 1 ###
##################

# Explore the distribution of price with geom_histogram() and other functions. Challenge yourself to go beyond the first plot you generate, which might might look something like this:


diamonds %>% 
  ggplot(aes(
    price, 
    fill = cut
    )) + 
  geom_histogram() +
  stat_bin(bins = 30)

 summary(diamonds$price)

# Most diamonds sold are around the $1000 price point
# The amount of diamonds sold at more expensive price points quickly drops at price increases
 
##################
### Question 2 ###
##################

#Which of the 4Cs (i.e., carat, cut, color, and clarity) is most important for predicting the price of a diamond?


ggplot(diamonds, aes(x = carat, y = price)) + 
  geom_point()
#Carat definitely seems to cause an upward trend
 
ggplot( diamonds, aes(x = cut, y = price)) +
  geom_boxplot()
# Cut does not appear to make much of a difference on the median price

ggplot(diamonds, aes(x = color, y = price)) +
  geom_boxplot()
#Definitely an upward trend on the median, but trend does not seem as pronounced yet as carat

ggplot(diamonds, aes(x = clarity, y = price)) +
  geom_boxplot()
# A pretty clear trend showing that different clarity points are connected to different prices

diamonds %>%
  mutate(carat_binned = cut(carat, breaks=c(seq(0, max(carat), .5), max(carat)))) %>%
  ggplot(., aes(x=carat_binned, y=price)) + 
  geom_boxplot()
# binning allows for better comparison against other categorical variables
# Carat obviously has the greatest effect on price

##################
### Question 3 ###
##################

# Visualize the distribution of carat, partitioned by price. 
# Then, after revisiting Faceting, use facet_wrap() to accomplish the same.

# Hint: After binning price, plot the distribution of carat for each bin. 
# Binning price can be accomplished with the following command:

diamonds <- diamonds %>% 
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  )


# So first, visualize distribution of carat, partitioned by price
diamonds %>% 
  ggplot(aes(price_binned, carat)) +
  geom_boxplot()

# Now do the same with facet_wrapping
diamonds %>% 
  ggplot(aes(price_binned, carat)) +
  geom_boxplot() +
  facet_wrap(~price_binned)

