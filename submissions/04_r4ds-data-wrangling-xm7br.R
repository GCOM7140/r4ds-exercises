#'---
#'name: Amanda Ma
#'title:"Data Wrangling Exercises"
#'output: github_document
#'date: March 31, 2019
#'---

```{r load-packages, warning = FALSE, message = FALSE}
library(nycflights13)
library(tidyverse)
```

You might also benefit from running `?flights` and `?who` to (re)familiarize yourself with these datasets.

--- 
  
#`**Question 1**: The `player` tibble below is meant to record De'Andre Hunter and Kyle Guy's dates of birth and heights. Why can't you tidy it up with the [`spread()`][12.3.2] function? How could you add a new column to `player` to fix the problem?


```{r, include = TRUE, warning = FALSE, eval = TRUE}
player <- tribble(
~name,             ~key,     ~value,
#----------------/---------/-----------------------
"De'Andre Hunter",    "dob", "December 2, 1997",
"De'Andre Hunter", "height", 201,
"De'Andre Hunter",    "dob", "August 11, 1997",
"Kyle Guy",           "dob", "August 11, 1997",
"Kyle Guy",        "height", 191
)
```

# Spreading the `player` tibble fails because there are two different observations for De'Andre's date of birth. R doesn't know which observation you'd prefer to keep, so it throws an error (i.e., "Error: Each row of output must be identified by a unique combination of keys."). In this instance, you can include a `keep` variable to drop the erroneous key-value combination where `keep == 2`:

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

#`**Hint:** You can use `group_by()` and `row_number()` to create a `keep` column that identifies unique combinations of keys. This `keep` column can be used to rid the data of the inaccurate observation for De'Andre's date of birth.
```

---
  
#`**Question 2**: Do you need to [gather][12.3.1] or [spread][12.3.2] `preg` (see below) to tidy it? What variables does `preg` include?
  
  ```{r, echo = TRUE}
preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)
```


```{r include = FALSE, eval = FALSE}
# `preg` needs to be gathered because it has values as variable names. The variables in `preg` are `pregnant`, `gender`, and `count`.
preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")
```

---
  
#`**Question 3**: How would you explain the warning message below in layman's terms to someone who couldn't figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the [`separate()`][12.4.1] function call. What could they do to remedy the situation?
  
 ```{r, echo = TRUE, eval = TRUE, warning = TRUE}
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))
```

```{r include = FALSE, eval = FALSE}
# The warning message indicates that the second observation has an extra value, and it is dropped by R. 
# We can change the `extra` argument to "merge"" rather than the "warn" default.
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")
```

---
  
#`**Question 4**: Both [`separate()`][12.4.1] and [`unite()`][12.4.2] have a remove` argument. What does it do? When does setting it to `FALSE` make sense?
  
 
```{r include = FALSE, eval = FALSE}
# If the `remove` argument is set to TRUE, R removes input column from output data frame.
```

---
  
#` **Question 5**: Using the [`who` dataset][12.6], calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the `who` dataset with:
  
  ```{r, echo = TRUE, eval = FALSE}
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  filter(country %in% c("China", "India", "Bangladesh")) %>%
  group_by(country, year) %>%
  mutate(cases = sum(value)) %>%
  ggplot(mapping = aes(x = year, y = cases, color = country)) +
  geom_point() + 
  geom_line()
  
#` India saw a spike in number of cases in 2007 that's surprising. China has seen a big leap in number of cases since 2008. Bangladesh saw a dip in year 2009 compare to the rest of the years. I might want to take a closer look into these unusual data points. 
```

---
  
#`**Question 6**: At what wind speeds are departure delays out of NYC the longest on average? You can begin addressing this question by joining observations in the `flights`dataset of the nycflights13 package with those in `weather` dataset of the same package by `origin`, `year`, `month`, `day`, and `hour`.
  #my script
flights %>%
  inner_join(weather, by = c("origin", "year","month", "day", "hour")) %>%
  mutate(
    wind_speed_binned = cut_width(wind_speed, width = 5, center = 2.5)
    ) %>%
  group_by(wind_speed_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE))%>%
  ggplot(aes(x = wind_speed_binned, y = dep_delay)) +
  geom_col()
  #answeer key
flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(
    wind_speed_binned = cut_width(wind_speed, width = 5, center = 2.5)
  ) %>%
  group_by(wind_speed_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_speed_binned, y = dep_delay)) +
  geom_col()

# Departure delays are longest when wind speeds are between 30 and 35 mph.
```
