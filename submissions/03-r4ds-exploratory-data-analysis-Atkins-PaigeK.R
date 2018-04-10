# Paige Atkins 
# 03-r4ds-exploratory-data

library(tidyverse)


#1 Plot the distribution of price. Describe the distribution. Hint: You can also use summary(diamonds$price) to view a quantitative assessment of the distribution
# There is a long tail the higher the price is

?geom_histogram
ggplot(diamonds, aes(price, ..density.., colour = cut)) + geom_freqpoly(binwidth = 500)


#2 Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond? 

#Carat below
ggplot(diamonds, aes(x=carat, y=price)) + geom_point()
#cut below
ggplot(diamonds, aes(x=cut, y=price)) + geom_boxplot()
#clarity below
ggplot(diamonds, aes(x=clarity, y=price)) + geom_boxplot()
#color below
ggplot(diamonds, aes(x=color, y=price)) + geom_boxplot()

#Carat has the most predictive power on price.


#3 Visualize the distribution of carat, partitioned by price. Hint: Bin the price and show the carat distribution for each bin. You can bin the data with this command:
#mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10))

diamonds %>% 
filter(!is.na(carat), !is.na(price)) %>%
mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), max(price)), dig.lab=10)) %>%
ggplot(., aes(price_binned, carat)) + geom_boxplot()


