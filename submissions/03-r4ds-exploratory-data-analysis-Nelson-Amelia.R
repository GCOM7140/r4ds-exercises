#' --- 
#' title: "r4ds exercise 3" 
#' author: Amelia Nelson
#' date: April 10, 2018 
#' output: github_document 
#' ---

library(tidyverse)
?diamonds

# Question 1: Explore the distribution of price with geom_histogram() and other functions. Use prose to describe the distribution you utlimately discover. What are some of the most surprising features of the distribution to you?

diamonds %>% 
  ggplot(aes(x = price)) + 
  geom_histogram(binwidth = 50)

# The graph 

# Question 2: Which of the 4Cs (i.e., carat, cut, color, and clarity) is most important for predicting the price of a diamond?

# carat vs price scatterplot
diamonds %>%
  ggplot(aes(x = carat, y = price)) +
  geom_point()
# carat vs price boxplot
diamonds %>%
  mutate(carat_binned = cut(carat, breaks = c(seq(0, max(carat), .5), max(carat)))) %>%
  ggplot(., aes(x = carat_binned, y = price)) + 
  geom_boxplot()

# cut vs price boxplot
diamonds %>%
  ggplot(aes(x = cut, y = price)) +
  geom_boxplot()

# color vs price boxplot
diamonds %>%
  ggplot(aes(x = color, y = price)) +
  geom_boxplot()

# clarity vs price boxplot
diamonds %>%
  ggplot(aes(x = clarity, y = price)) +
  geom_boxplot()

# It is clear that carat is the biggest factor of determining price. The scatterplot and boxplot of carat versus price shows a postiive relationship whereas, with the other boxplots, the ranges of prices are fairly uniform across the different factors. Also, we can tell that the relationship between carat and price is roughly exponential. From a one carat diamond to a 2 carat diamond, there is a huge jump in price. After 2 carats, prices don't differentiate by carat as much.

# Question 3: Visualize the distribution of carat, partitioned by price. Then, after revisiting Faceting, use facet_wrap() to accomplish the same.

diamonds %>%
  filter(!is.na(carat), !is.na(price)) %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), max(price)),
                       dig.lab = 10)) %>% 
  ggplot(., aes(price_binned, carat)) +
  geom_boxplot()

 # using Faceting
diamonds %>%
  filter(!is.na(carat), !is.na(price)) %>% 
  mutate(price_binned = cut(price, 
                            breaks = c(seq(0, max(price), 5000), Inf),
                            dig.lab = 10)) %>% 
  ggplot(., aes(x = carat, fill = price_binned)) +
  geom_histogram(bins = 50, show.legend = FALSE) +
  facet_wrap(~ price_binned, scales = 'free_y', ncol = 1)

# For the lowest price range (0 - $5000), is unsurprisingly skewed left, with carat sizes ranging from 0.5 - 1.5 and weighted heavily towards 0.5 carat. With the next three price ranges, the ranges are similar (1-2.5 carats), but the way the curve is distributed in this range differs. For the second tier price range ($5000 - $10,0000), most diamonds are 1 carat. For the third tier ($10,000 - $15,000), most diamonds are 1.5 carat and there are also a fair amount around 2 carats. Lastly, the priciest range ($150,000+), most diamonds are 2 carats.  
