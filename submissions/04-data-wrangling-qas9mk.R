#Question 1

player %>% 
  group_by(name, key) %>% 
  mutate(keep = row_number()) %>% 
  spread(key, value) %>% 
  filter(keep == 1)

#Question 2

#male and female are values, not names: it needs to be gathered

preg %>% 
  gather(`male`, `female`, key = "gender", value = "count")

#Question 3

#row 2 has 4 letters, it should have 3. the "g" will be dropped. The 'extra' argument should be set to merge rather than warn to fix this. 

#Question 4

#The remove argument deletes the original columns that the separate and unite functions deal with. In situations where you want to keep the original column for further manipulation, this is not possible. 

#Question 5

#pass

#Question 6

flights %>%
  inner_join(weather, by = c("origin", "year", "month", "day", "hour")) %>%
  mutate(
    wind_speed_binned = cut_width(wind_speed, width = 5, center = 2.5)
  ) %>%
  group_by(wind_speed_binned) %>%
  summarize(dep_delay = mean(dep_delay, na.rm = TRUE)) %>%
  ggplot(aes(x = wind_speed_binned, y = dep_delay)) +
  geom_col()

#30-35 is the speed