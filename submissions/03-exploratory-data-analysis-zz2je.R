library(tidyverse)

#Question 1: Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(data=diamonds) +
  geom_histogram(mapping = aes(x=price),binwidth = 200)
# The distribution of price is highly skewed to the right. While majority of the prices are distributed around $1000 (as a peak in the distribution), a long but thin tail of higher prices extending all the way beyond $15000.


#Question 2: Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?
ggplot(data=diamonds,aes(x=carat,y=price))+
  geom_point()
# A positive relationship between carat and price can be observed with scatterplot.

ggplot(data=diamonds)+
  geom_boxplot(mapping = aes(x=cut, y=price))

ggplot(data=diamonds)+
  geom_boxplot(mapping = aes(x=clarity, y=price))

ggplot(data=diamonds)+
  geom_boxplot(mapping = aes(x=color, y=price))
# Relationship between cut, clarity and color with price can be explored with boxplots. For cut, across levels from fair to ideal, the distributions of price are similar to one and another, with median price around $2500, interquartile range from $1250 tp $5000 and long tail extending to prices beyond $15000. For clarity, diamond with levels of I1, SI2 and SI1 generally have higher median price around $3250, levels of VS2 and VS1 have median price around $2000, and levels of VVS2, VVS1 and IF have relatively lower median prices around $1250; the distributions of price across different clarity levels are similar, with a long tail extending to prices beyond $15000. For color, diamond with color levels of D and E generally have lowest median price around $2000, color levels of F and G have median price around $2500, and color levels of H, I and J have relatively higher median prices around $3500; the distributions of price across different color levels are generally similar, with a long tail extending to prices beyond $15000; but interquartile ranges of color levels of G,H,I and J are relatively larger. Thus, probably carat has the strongest power to predict price of a diamond.


#Question 3: Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

  ggplot(data= diamonds,mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250)))
  
  diamonds %>%
    mutate(
      price_binned = price %>% 
        cut_width(width = 2500, center = 1250) %>% 
        fct_relevel(rev)
    ) %>% 
    ggplot(mapping = aes(x = carat)) +
    geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
    facet_wrap(~price_binned, scales = "free_y", ncol = 1)
  
  