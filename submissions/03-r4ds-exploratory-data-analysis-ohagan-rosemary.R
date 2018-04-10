####### Rosemary O'Hagan ###########    
####### Customer Analytics HW #3 ###
####### 4/10/18 ####################

library(tidyverse)
?diamonds

################################################################################
################################################################################
# Question 1. Explore the distribution of price with geom_histogram() and other functions. Challenge yourself to go beyond the first plot you generate, which might might look something like this:

diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()

summary(diamonds$price)

diamonds %>% 
  ggplot() +
  geom_bar(mapping = aes(price))

diamonds %>% 
  ggplot() +
  geom_boxplot(mapping = aes(cut, price))

# There are far more diamonds under 5,000 as evident by the mean of 3,933 and the disparity between the difference of 1st quartile of 950 and the mean and the difference of the 3rd quartile of 5,324 and the mean. The maximum price for a diamond is around 18,823 however this represents a long tail in both the histogram and the bar chart visualizations. 

################################################################################
################################################################################
# Question 2. Which of the 4Cs (i.e., carat, cut, color, and clarity) is most important for predicting the price of a diamond?
  
diamonds %>% 
  ggplot() +
  geom_point(mapping = aes(x=carat, y=price)) #Fairly linear relationship. Higher the carat the higher the price. 

diamonds %>% 
  ggplot() +
  geom_boxplot(mapping = aes(x=cut, y=price)) #No predictive power.

diamonds %>% 
  ggplot() +
  geom_boxplot(mapping = aes(x=color, y=price)) #A little bit better than cut but not as strong as carat.

diamonds %>% 
  ggplot() +
  geom_boxplot(mapping = aes(x=clarity, y=price)) #A little bit better than color but not as strong as carat. 

Visualize the distribution of carat, partitioned by price. Hint: Bin the price and show the carat distribution for each bin. You can bin the data with this command:

################################################################################
################################################################################
# Question 3. Visualize the distribution of carat, partitioned by price. Hint: Bin the price and show the carat distribution for each bin. You can bin the data with this command:   

diamonds %>% 
mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10)) %>% 
  ggplot(., aes(x=carat, fill=price_binned)) + 
  geom_histogram(bins=50, show.legend = FALSE) + 
  facet_wrap(~ price_binned, scales = 'free_y', ncol = 1)
