#Prepping

library(tidyverse)
?diamonds

############
#Question 1: Plot the distribution of price. Describe the distribution. Hint: You can also use summary(diamonds$price) to view a quantitative assessment of the distribution. This question is 7.3.4.#2 and grows your ability to plot a histogram to view a distribution

ggplot(data = diamonds) + 
geom_histogram(mapping = aes(x=price), binwidth = 30)

#We can see from this distribution that there is a large clumping of diamonds in the low price range, with a long tail that shows the really expensive diamonds. Basically, diamonds worth a high price are rarer than diamonds which fetch a low price, nothing surprising.

############
#Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond? This question is based on 7.5.1.1.#2 and grows your ability to interpret variable relationships from plots (link).

#Let's run some line graphs and find out!

#First, carat
ggplot(diamonds, aes(x=carat, y=price)) + 
geom_line()
#Here, we can see a strong correlation between price and carat

#Line graphs don't work on the rest sadly, got to run some other plots
#Cut
ggplot(diamonds, aes(x=cut, y=price)) + 
geom_col()
#There is also correlation here, the better the cut, the higher the price

#Clarity
ggplot(diamonds, aes(x=clarity, y=price)) + 
geom_col()
#Certain types of clarity tend to draw a higher price, but I wouldnt say there is a significant difference between the highest level of clarity and 2nd highest in price...murkey correlations here. Price does not necessarily ncrease with clarity increases.

#Color
ggplot(diamonds, aes(x=color, y=price)) + 
geom_col()
#Some colors draw higher prices, but there isn't a particularly significant difference between some levels. Clearly, quality of color does not predict price, but its true that G quality tends to fetch a higher price. Would have to investigate these diamonds specifically as to why, or maybe G quality color tends to have high carat or cut...

#Overall, I would argue that both carat and cut are predictors of price, when combined they would likely predict better than alone. Clarity and Color are not predictors.

############
#Question 3: Visualize the distribution of carat, partitioned by price. Hint: Bin the price and show the carat distribution for each bin. You can bin the data with this command:
  
#mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), Inf), dig.lab=10))

#In this question you are also encouraged to try and use faceting. Review Section 3.5 for details on facetting. This question is based on 7.5.3.#2 and grows your ability to interpret variable relationships from plots (link).

#import the code
diamonds %>% 
mutate(price_binned = cut(price, breaks=c(seq(0, max(price), 5000), max(price)), dig.lab=10)) %>%
#building a violin chart, after looking through the plots available I think this one works really well here (and looks awesome)
ggplot(., aes(price_binned, carat)) + 
geom_violin() +
#Trying out facet wrap here but to be honest I think we get a better "at a glance" comparison of bins without it, though I really like the "scaling" legend for each bin.
facet_wrap(~ price_binned, scales = 'free_y', ncol = 1)
#Using more than 1 column causes text smushing issues so just went with one, but more are interesting.

#r4ds exercise 3 complete! (I think, I don't see a question 4 or 5 on github...)