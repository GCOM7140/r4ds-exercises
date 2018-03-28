# r4ds 1 ------------------------------------------------------------------

flights %>% 
  filter(dest == "ORD") %>% 
  nrow()

flights %>% 
  filter(origin == "ORD") %>% 
  nrow()

flights %>% 
  filter(distance < 100) %>% 
  nrow()

flights %>% 
  filter(dest %in% c("IAH", "HOU"),
         origin != "JFK") %>% 
  nrow()


# r4ds 2 ------------------------------------------------------------------

flights %>% 
  filter(is.na(arr_time), !(is.na(dep_time)))


# r4ds 3 ------------------------------------------------------------------

flights %>% 
  arrange(desc(is.na(arr_time)))


# r4ds 4 ------------------------------------------------------------------

select(flights, contains("TIME", ignore.case = FALSE))


# r4ds 5 ------------------------------------------------------------------

flights %>% 
  group_by(dest) %>% 
  mutate(total_min_delay = sum(dep_delay)) %>% 
  ungroup() %>% 
  mutate(total = sum(total_min_delay),
         prop = (total_min_delay/total)) %>% 
  arrange(desc(prop)) %>% 
  filter(!(is.na(prop))) %>% 
  select(prop, dest, everything())  