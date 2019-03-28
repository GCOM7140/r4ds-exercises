# r4ds
---
  title: "Data Visualization Solutions"
author: Sebastian Cook
---
  
  ```{r setup, include = FALSE}
knitr::opts_chunk$set(echo = TRUE)
```

```{r load-packages, warning = FALSE, message = FALSE}
library(tidyverse)
```

--- 
  
  **Question 1**: Run `ggplot(data = mpg)`. What do you see?  
  

```{r include = TRUE, eval = TRUE}
ggplot(data = mpg)

# This graph is completely empty, is this a template for a subsequent addition. ``

---
  
  **Question 2**: Make a scatterplot of `cyl` vs `displ`. Then, make a boxplot
with the same variables. What additional information does the boxplot convey?

```{r include = TRUE, eval = TRUE}
ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# The scatterplot shows a positive correlation between cylinders and displacements. The boxplots show more details, suchas IQR, the means, and outliers. The latter is particular relevant for larger size cylinders. For every incrase in cylinders of 2, engine increases by approximately 1.5.````
---
  
  **Question 3**: What happens if you make a scatterplot of `class` vs `drv`? Why
is the plot not useful? Create an alternative visualization that displays the
data more effectively.

```{r include = TRUE, eval = TRUE}
ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# The first plot features multiple observations on the same axis, somewhat cluttering the data. Separating this out through the use of the geom_bar(mapping) function can make it more readable and gauge the proportion of observations more clearly.
```  

---
  
  **Question 4**: What geom would you use to draw:
  
  - A line chart? 
  - A boxplot?
  - A histogram?
  - An area chart? 

```{r include = TRUE, eval =  FALSE}
# - geom_line()
# - geom_boxplot()
# - geom_histogram()
# - geom_area() or geom_bar()
```

---
  
  **Question 5**: Will these two graphs look different? Why/why not?
  
  ```{r eval = FALSE}
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))
```

```{r include = TRUE, eval = TRUE}
# The graphs appear identical, but the code used allows different solutions to arise in the future. For example, the first argument enters the data into the global ggplot() function, whereas the second puts then into 'gg_smooth` and `geom_point`. Different object mappings allow a degree of flexibility across layers of visualisation.
```