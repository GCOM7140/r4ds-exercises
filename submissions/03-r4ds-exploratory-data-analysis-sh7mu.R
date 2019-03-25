library(tidyverse)

#' Q1 - Explore the distribution of price. Do you discover anything unusual or
#' surprising? (Hint: Carefully think about the binwidth and make sure you try a
#' wide range of values.)

ggplot(data = diamonds) +
  geom_histogram(mapping = (aes(x = price)), binwidth = 100)

#' There is a long tail, with most of the diamonds being priced ar around $1000.
#' The most expensive diamonds are few in number.
 

#' Q2 - Which of the 4Cs (carat, cut, clarity, color) is most important for
#' predicting the price of a diamond?
 


#' Q3 - Plot the distribution of carat across various price bins using the
#' geom_boxplot() and geom_histogram() functions. For the latter, leverage the
#' facet_wrap() function.

#' How would you describe the relationship between carat and price based on these visualizations?