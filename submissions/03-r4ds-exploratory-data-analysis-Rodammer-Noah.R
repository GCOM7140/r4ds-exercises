#' ---
#' title: "Answers to the R4DS Exploratory Data Analysis (EDA) Exercise"
#' author: Noah Rodammer
#' date: April 11, 2018
#' output: github_document
#' ---


library(tidyverse)

#' **Question 1**: Explore the distribution of price with geom_histogram() and 
#' other functions. Challenge yourself to go beyond the first plot you generate, 
#' which might might look something like this:

diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram()

#' Use prose to describe the distribution you utlimately discover. What are some 
#' of the most surprising features of the distribution to you?
#' 
#' Hint: It might help if you first view a quantitative assessment of the 
#' distribution with summary(diamonds$price).

summary(diamonds$price)

#boxplot for statistics
ggplot(diamonds, aes(x=1, y=price)) + geom_boxplot() + 
  xlab(NULL) + theme(axis.text.y=element_blank()) +
  coord_flip()

#frequency plot for visual
diamonds %>%
  ggplot(aes(price)) +
  geom_freqpoly()

#histogram for visual
diamonds %>% 
  ggplot(aes(price)) + 
  geom_histogram(bins=50)



#' Above are three different ways to visualize the data to better understand
#' the distribution of price. As seen in the boxplot, the median price is
#' $2,401. This means that more than half of the diamonds are less expensive
#' than that. Further, 25% of the data is below $950 (plot 1). The first 
#' histogram#' provided was deceiving because there were too few bins so you 
#' don't see the initial spike and then dip after $1,000 (plots 2 and 3).


#' **Question 2**: Which of the 4Cs (i.e., carat, cut, color, and clarity) is
#'  most important for predicting the price of a diamond?


diamonds %>%
  mutate(caratBin = cut(carat,c(seq(0,max(carat),.5)))) %>%
  ggplot(aes(x=caratBin,y=price)) +
  geom_boxplot()

diamonds %>%
  ggplot(aes(x=cut,y=price)) +
  geom_boxplot()

diamonds %>%
  ggplot(aes(x=color,y=price)) +
  geom_boxplot()

diamonds %>%
  ggplot(aes(x=clarity,y=price)) +
  geom_boxplot()

#' Visually, carat is easily the most important for predicting price; the others 
#' have very simliar distributions and medians.

diamonds$caratBin <-cut(diamonds$carat,c(seq(0,max(diamonds$carat),.5)))

caratM<-lm(price~caratBin,data=diamonds)
summary(caratM)

cutM<-lm(price~cut,data=diamonds)
summary(cutM)

colorM<-lm(price~color,data=diamonds)
summary(colorM)

clarityM<-lm(price~clarity,data=diamonds)
summary(clarityM)

#' Statistically, carat significantly has the highest t values for a linear 
#' model  


#' **Question 3**: Visualize the distribution of carat, partitioned by price. 
#' Then, after revisiting Faceting, use facet_wrap() to accomplish the same. 


diamonds %>% 
  mutate(
    price_binned = cut(price, breaks = c(seq(0, max(price), 5000), Inf), 
                       dig.lab = 10)
  ) %>%
  ggplot(aes(price_binned)) + 
  xlab("carat") +
  ylab("number of diamonds") +
  geom_histogram(bins=50,aes(carat)) +
  facet_wrap(~price_binned,scales='free_y',ncol=1)

#' Note for classmates, if you don't use scales 'free_y', then you're going to
#' have really squished histograms for the most expensive diamonds because
#' there are much fewer of them.
#' 
#' General observation is the shift in skew of these from right skew to
#' relatively normal distribution to slight left skew.
