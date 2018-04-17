library(tidyverse)
library(here)

# pattern for names "lastname-firstname"

r4ds_01 <- str_glue("01-r4ds-data-transformation-", names, ".R")

str_detect(
  list.files(here("submissions")), r4ds_01
)