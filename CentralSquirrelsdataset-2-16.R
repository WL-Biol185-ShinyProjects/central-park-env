library(tidyverse)
squirrel_data <- read_csv("2018_Central_Park_Squirrel_Census_-_Squirrel_Data_20260216.csv")
view(squirrel_data)
hectare_data <- read_csv("2018_Central_Park_Squirrel_Census_-_Hectare_Data_20260216.csv")
view(hectare_data)
story_data <- read_csv("2018_Central_Park_Squirrel_Census_-_Stories_20260216 (1).csv")
view(story_data)

library(dplyr) # joining the datasets together
library(purrr)

df_list <- list(squirrel_data, hectare_data, story_data) # add all your dataframes to a list

central_park <- df_list %>%
  reduce(inner_join, by = c("Hectare", "Shift", "Date"))

view(central_park)
