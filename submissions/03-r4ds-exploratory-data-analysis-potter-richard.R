# Richard Potter
# Exploratory Data Analysis (EDA) Exercises
# Professor Boichuk
# 10 April 2018


# Initial Operations ------------------------------------------------------

library(tidyverse)
?diamonds


# Exercise 1 --------------------------------------------------------------
# Explore the distribution of `price` with `geom_histogram()` and other functions. Challenge yourself to go beyond the first plot you generate, which might might look something like this:

diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()

summary(diamonds$price)

diamonds %>% 
  ggplot(aes(price)) +
  geom_histogram(binwidth = 200)

diamonds %>% 
  ggplot(aes(price)) +
  geom_histogram(binwidth = 100)

diamonds %>% 
  ggplot(aes(price)) +
  geom_density()

diamonds %>% 
  ggplot(aes(price)) +
  geom_boxplot()

# In the ends, I am not surprised that the data follow a distribution which declines rapidly, almost exponentially from the start. Furthermore, it seems that there are bumps around the 1st quartile and mean prices of 950 and 3933 (here, more in the 4000s, below the large number of $5000. I would attribute this to being a little under 1000 and 4000 dollars. With more nuanced evaluation, it may be clear that it is following price psychology, and that many of the diamonds are priced immediately below large numbers to give the illusion of a larger number.


# Exercise 2 --------------------------------------------------------------

# Which of the 4Cs (i.e., `carat`, `cut`, `color`, and `clarity`) is most important for predicting the `price` of a diamond?

ggplot(diamonds) + 
  geom_point(aes(x = carat,     y = price))
ggplot(diamonds) + 
  geom_boxplot(aes(x = cut,     y = price))
ggplot(diamonds) + 
  geom_boxplot(aes(x = color,   y = price))
ggplot(diamonds) + 
  geom_boxplot(aes(x = clarity, y = price))

# Based on the plots, it seems that the largest predictor for the price of a diamond is the number of carats it contains.


# Exercise 3 --------------------------------------------------------------

# Visualize the distribution of `carat`, partitioned by `price`. Then, after revisiting [Faceting][G&W 2017, 3.5], use `facet_wrap()` to accomplish the same. **Hint:** After binning `price`, plot the distribution of `carat` for each bin. Binning `price` can be accomplished with the following command:
                                                          
diamonds %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf),
                            dig.lab = 10)) %>% 
  ggplot() +
  geom_boxplot(aes(price_binned, carat))

diamonds %>% 
  mutate(price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf),
                            dig.lab = 10)) %>% 
  ggplot() +
  geom_histogram(aes(carat)) +
  facet_wrap(~ price_binned)
