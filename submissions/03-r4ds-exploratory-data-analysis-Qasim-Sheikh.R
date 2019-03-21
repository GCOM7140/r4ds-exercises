data(diamonds)
df <- diamonds

#Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

qplot(diamonds$price, geom = "histogram")
qplot(diamonds$price, geom = "histogram", binwidth = 10)
qplot(diamonds$price, geom = "histogram", binwidth = 100)
qplot(diamonds$price, geom = "histogram", binwidth = 3)
#this binwidth shows that there are a surprising amount of diamonds at about the $1000 range: it is by far the largest bin

#Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

#pass

#Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

diamonds %>%
ggplot( mapping = aes(x = price, y = carat)) 
+ geom_boxplot(mapping = aes(group = price %>% cut_width(width = 2000, center = 1250)))

