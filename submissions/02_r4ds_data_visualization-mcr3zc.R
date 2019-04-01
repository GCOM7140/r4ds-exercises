#Load the Tidyverse 
library(tidyverse)
library(cars)


#Question 1: Run GG Plot(data = mpg) 

ggplot(data = mpg)

```{r include = TRUE, eval = TRUE}
ggplot(data = mpg)

#An empty grey box appears in the plots tab of R Studio. 


#Question 2: Make a scatterplot of 'cyl' vs 'displ'. Then, make a boxplot with the same variables. What additional information does the boxplot convey? 

```{r include = TRUE, eval = TRUE}
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()
ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()
  
#several different boxplots plotting cylinder against engine displacement. The boxplots also show the medians, the second boxplot is very thin it is just a median. The plot illustrates that for cylinders, engine displacement increases so the more cylinders the car has the more (on average, and with both minimum and maximum), of engine displacement. 

  
#Question 3**: What happens if you make a scatterplot of `class` vs `drv`? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.


```{r include = TRUE, eval = TRUE}
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()
ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

#When plotted as a scatterplot, the graph shows many items in the same x and y continumm and we are not looking for a linear relationship here instead we are looking for a quantity (proportion) based one, so the bar chart illustrates this proportion of car class and driver # more simply. 

#What geom would you use to draw: 

#A line chart 

#geom_line () 

#A boxplot 

#geom_boxplot()

#A histogram 

#geom_histogram()

#An area chart 

#geom_area()

#Question 5: Will these two graphs look different? 

  ```{r eval = FALSE}
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()
ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

#The two graphs appear to be identical however the first one incorporates fewer terms because it takes the function data to be globally relevant in the (ggplot) function by making the assignment so that they do not have to be entered repeatedly. 


