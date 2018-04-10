#' ---
#' title: "Answers to the R4DS 03 Data Transformation Exercise"
#' author: Robert Papel
#' date: April 9, 2018
#' output: github_document
#' ---

library(tidyverse)


#' **Exercise 1**: Explore the distribution of price with geom_histogram() and
#' other functions. Challenge yourself to go beyond the first plot you generate,
#' which might might look something like this:
 
diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram(aes(price), binwidth = 50)

summary(diamonds$price)
 
#'If you change it to the bar chart, you get a HUGE spread, so a histogram is
#'definitely the best option. I think the histogram automatically does count on
#'the y-axis, so just using price for aes() is definitely the move. Quite a lot
#'of diamonds are under $5000 in price, with the long tail moving out as prices
#'go up. I think this makes sense, for diamonds and price.


#' **Exercise 2** :Which of the 4Cs (i.e., carat, cut, color, and clarity) is
#' most important for predicting the price of a diamond?

diamonds %>% 
  select("carat", "cut", "color", "clarity", "price") %>% 
  ggplot(aes(x = carat, y = price)) +
  geom_point()
#' this plot shows shows a huge rise with price and carat. You can also run a
#' regression (line fit), and see the stats using the summary argument
  
diamonds %>% 
  select("carat", "cut", "color", "clarity", "price") %>% 
  ggplot(aes(x = cut, y = price)) +
  geom_point()
#' this plot shows nothing valuable, or usable  

diamonds %>% 
  select("carat", "cut", "color", "clarity", "price") %>% 
  ggplot(aes(x = clarity, y = price)) +
  geom_point()
#' useless plot

diamonds %>% 
  select("carat", "cut", "color", "clarity", "price") %>% 
  ggplot(aes(x = color, y = price)) +
  geom_point()
#' also useless, just bars with color and the price. shows nothing

 
#' **Exercise 3** : Visualize the distribution of carat, partitioned by price.
#' Then, after revisiting Faceting, use facet_wrap() to accomplish the same.

diamonds %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)) %>% 
  ggplot(aes(price_binned, carat)) +
  geom_boxplot() +
  facet_wrap(~ price_binned)

#' To be honest, not really sure what I am getting with these 4 separate graphs.
#' I understand that it is binned within price, but not much else








