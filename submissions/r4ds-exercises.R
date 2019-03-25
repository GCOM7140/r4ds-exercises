library(tidyverse)
library(nycflights13)

# +++++ QUESTION 1 +++++

# How many flights flew into LAX?

flights %>%
  filter(dest == "LAX") %>%
  nrow()

# How many flights flew out of LAX?

flights %>%
  filter(origin == "LAX") %>%
  nrow()

# How many flights were longer than or equal to 2,000 miles in distance?

flights %>%
  filter(distance >= 2000) %>%
  nrow()

# How many flights were destined for airports in the Los Angeles area (LAX, ONT, SNA, PSP, SBD, BUR, or LGB), but did not originate out of JFK?

flights %>%
  filter(dest %in% c("LAX", "ONT", "SNA", "PSP", "SBD", "BUR", "LGB"),
         origin != "JFK") %>%
  nrow()

# +++++ QUESTION 2 +++++

# How many flights were "ghost flights"? A "ghost flight" is defined as a flight that departed, but never arrived (i.e., has a missing value for arr_time).

flights %>%
  filter(!is.na(dep_time), is.na(arr_time)) %>%
  nrow()

# +++++ QUESTION 3 +++++

# How does arrange() treat missing values, and how could you sort all of the rows with a missing arr_time to the top of the dataset?

flights %>%
  arrange(desc(is.na(arr_time)))

# +++++ QUESTION 4 +++++

# What do you observe after running the code below? How does this behavior reflect how select() helpers deal with uppercase and lowercase matching by default? How can you override this default behavior?

select(flights, contains("TIME"))

# This shows that select() helpers are case sensitive in terms of matching. You can override this by using the ignore.case argument and setting it to "TRUE". 

select(flights, contains("TIME", ignore.case = TRUE))

# +++++ QUESTION 5 +++++

# For each destination more than or equal to 2,000 miles away from NYC's airports, compute the total number of minutes their arrivals were delayed. Then, determine how much, as a percentage, each of these destinations contributed to the total number of arrival-delay minutes that long-haul destinations (i.e., those more than or equal to 2,000 miles away from NYC's airports) amassed in 2013. Which three destinations top the list?

flights %>%
  filter(distance >= 2000, arr_delay > 0) %>%
  group_by(dest) %>%
  summarize(arr_delay_mins = sum(arr_delay)) %>%
  mutate(arr_delay_pct_of_total = arr_delay_mins / sum(arr_delay_mins)) %>%
  arrange(desc(arr_delay_pct_of_total)) %>% 
  head(3)

# ++++++++ DATA VISUALIZATION ++++++++

# +++++ QUESTION 1 +++++

# Run ggplot(data = mpg). What do you see?

ggplot(data = mpg)

# There is a blank canvas.

# +++++ QUESTION 2 +++++

# Make a scatterplot of cyl vs displ. Then, make a boxplot with the same variables. What additional information does the boxplot convey?

ggplot(data = mpg, aes(x = cyl, y = displ)) + 
  geom_point()

ggplot(data = mpg, aes(x = as.factor(cyl), y = displ)) + 
  geom_boxplot()

# The boxplot gives additional information such as medians, interquartile ranges, and outliers. This helps us see more clearly that there is a positive relationship between cylinders and engine displacement. 

# +++++ QUESTION 3 +++++

# What happens if you make a scatterplot of class vs drv? Why is the plot not useful? Create an alternative visualization that displays the data more effectively.

ggplot(mpg, aes(x = class, y = drv)) +
  geom_point()

# It's impossible to tell the differing proportions of drives.

ggplot(mpg) +
  geom_bar(mapping = aes(x = class, fill = drv), position = "fill")

# +++++ QUESTION 4 +++++

# What geom would you use to draw:
  
  # A line chart? - geom_line()
  # A boxplot? - geom_boxplot()
  # A histogram? - geom_histogram()
  # An area chart? - geom_area() or geom_bar()

# +++++ QUESTION 5 +++++

# Will these two graphs look different? Why/why not?

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_point() + 
  geom_smooth()

ggplot() + 
  geom_point(data = mpg, mapping = aes(x = displ, y = hwy)) + 
  geom_smooth(data = mpg, mapping = aes(x = displ, y = hwy))

# The graphs are the same, but the first one is more efficient.

# ++++++++ EXPLORATORY DATA ANALYSIS ++++++++

# +++++ QUESTION 1 +++++

# Explore the distribution of price. Do you discover anything unusual or surprising? (Hint: Carefully think about the binwidth and make sure you try a wide range of values.)

ggplot(data = diamonds) + 
  geom_histogram(mapping = aes(x = price), binwidth = 100)

# The majority of diamonds have a price of around $1,000. There are quite a few with a price just below $5,000.

# +++++ QUESTION 2 +++++

# Which of the 4Cs (carat, cut, clarity, color) is most important for predicting the price of a diamond?

# Carat and price
ggplot(diamonds, aes(x = carat, y = price)) +
  geom_point() + 
  geom_smooth()

# Cut and price
ggplot(diamonds, aes(x = cut, y = price)) +
  geom_boxplot()

# Clarity and price
ggplot(diamonds, aes(x = clarity %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

# Color and Price
ggplot(diamonds, aes(x = color %>% fct_reorder(price), y = price)) +
  geom_boxplot() + 
  coord_cartesian(ylim = c(0, 7500))

# Carat and price boxplot
diamonds %>%
  ggplot(mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, .25)))

# Carat is the most significant, as it has the strongest relationship with price. 

# +++++ QUESTION 3 +++++

# Plot the distribution of carat across various price bins using the geom_boxplot() and geom_histogram() functions. For the latter, leverage the facet_wrap() function.

diamonds %>%
  ggplot(mapping = aes(x = price, y = carat)) +
  geom_boxplot(
    mapping = aes(group = price %>% cut_width(width = 2500, center = 1250))
  )

diamonds %>%
  mutate(
    price_binned = price %>% 
      cut_width(width = 2500, center = 1250) %>% 
      fct_relevel(rev)
  ) %>% 
  ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = .125 , center = 0, show.legend = FALSE) +
  facet_wrap(~price_binned, scales = "free_y", ncol = 1)

#How would you describe the relationship between carat and price based on these visualizations?

# There seems to be a positive relationship between carat and price. 

# ++++++++ DATA WRANGLING ++++++++

# +++++ QUESTION 1 +++++

# The player tibble below is meant to record De’Andre Hunter and Kyle Guy’s dates of birth and heights. Why can’t you tidy it up with the spread() function? How could you add a new column to player to fix the problem?

player <- tribble(
  ~name,             ~key,     ~value,
  #----------------/---------/-----------------------
  "De'Andre Hunter",    "dob", "December 2, 1997",
  "De'Andre Hunter", "height", 201,
  "De'Andre Hunter",    "dob", "August 11, 1997",
  "Kyle Guy",           "dob", "August 11, 1997",
  "Kyle Guy",        "height", 191
)

# You can't tidy it with the spread() function because there are two different values for De'Andre Hunter's date of birth. You can include a 'keep' variable to include the correct key-value combination and drop the other one. 

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

# +++++ QUESTION 2 +++++

# Do you need to gather or spread preg (see below) to tidy it? What variables does preg include?

preg <- tribble(
  ~pregnant, ~male, ~female,
  #--------/------/---------
  "yes",        NA,      10,
  "no",         20,      12
)

# Yes, because it has values as variable names. preg includes the variables 'pregnant', 'gender', and 'count'. 

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

# +++++ QUESTION 3 +++++

# How would you explain the warning message below in layman’s terms to someone who couldn’t figure out what it means? Suppose they want to make sure that every piece of the tibble makes its way into the result of the separate() function call. What could they do to remedy the situation?

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"))

# The warning message indicatest that the second observation has an extra value and that this value was dropped. You can remedy this situation by setting the 'extra' argument to "merge" rather than "warn". 

tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>% 
  separate(x, c("one", "two", "three"), extra = "merge")

# +++++ QUESTION 4 +++++

# Both separate() and unite() have a remove argument. What does it do? When does setting it to FALSE make sense?

# The 'remove' argument determines whether R should remove or keep the original columns being parsed. Sometimes it might make sense to not keep columns for troubleshooting purposes or other operations.

# +++++ QUESTION 5 +++++

# Using the who dataset, calculate the total number of cases of TB per year for China, India, and Bangladesh, then plot these statistics over time. What country-year statistics, if any, surprise you? You can tidy the who dataset with:

who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>% 
  mutate(code = gsub("newrel", "new_rel", code)) %>%
  separate(code, c("new", "var", "sexage")) %>% 
  select(-new, -iso2, -iso3) %>% 
  separate(sexage, c("sex", "age"), sep = 1) %>%
  group_by(country, year) %>%
  summarise(cases = sum(value)) %>%
  filter(country %in% c('China', 'India', 'Bangladesh')) %>% 
  ggplot(aes(x = year, y = cases, colour = country)) +
  geom_point() + 
  geom_line()

# There was a huge spike in 2007 in India, a increase of almost 750,000 from the last data point.

# +++++ QUESTION 6 +++++

# At what wind speeds are departure delays out of NYC the longest on average?

flights %>%
inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(
    wind_speed_binned = cut_width(wind_speed, width = 5, center = 2.5)
  ) %>%
  group_by(wind_speed_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_speed_binned, y = dep_delay)) +
  geom_col()

flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  ggplot(aes(x = wind_speed, y = dep_delay)) +
  geom_smooth()

# Departure delays are longest when wind speeds are between 30 and 35 mph. 
